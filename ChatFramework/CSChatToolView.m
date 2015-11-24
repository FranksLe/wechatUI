//
//  CSChatToolView.m
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#define KCONTENT_FONT 18
#define KINPUTVIEW_HEIGHT 50
#define KASSIGANTVIEW_HEIGHT 216
#define KBUTTON_SIZE 30
#define KGAP 5
#define CHAT_FILE_NAME @"ChatResourse"
#import "CSChatCommnd.h"
#import "CSChatToolView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import "UUProgressHUD.h"
#import "FaceBoard.h"
#import "ChatAssistanceView.h"
@interface CSChatToolView ()<UITextViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate,FaceBoardDelegate>

@property (strong ,nonatomic) FaceBoard *faceBoard;
@property (strong ,nonatomic) UIView *chatInputView; // 键盘表情输入框视图
@property (strong ,nonatomic) UIImageView *backgroundView;
@property (strong ,nonatomic) UIButton *messageBtn;
@property (strong ,nonatomic) UIButton *moreItemBtn;
@property (strong ,nonatomic) UIButton *emojiBtn;
@property (strong ,nonatomic) UIButton *talkBtn;
@property (strong ,nonatomic) UIView *contentView;
@property (strong ,nonatomic) UIImageView *contentBackground;
@property (strong ,nonatomic) UITextView *contentTextView;
@property (weak ,nonatomic) NSObject<CSChatToolViewKeyboardProtcol> *observer;
@property (assign ,nonatomic) CGRect hiddenKeyboardRect;
@property (assign ,nonatomic) CGRect showkeyboardRect;
@property (strong ,nonatomic) AVAudioRecorder *recorder;
@property (assign ,nonatomic) CGFloat recordTime;// 录音时间
@property (strong ,nonatomic) NSTimer *recordTimer;// 定时器
@property (strong ,nonatomic) ChatAssistanceView *assistanceView;
@end
@implementation CSChatToolView

- (instancetype)initWithObserver:(NSObject<CSChatToolViewKeyboardProtcol>*)object{
    self = [super init];
    if (self) {
        if (object) {
              _observer = object;
        }
        _hiddenKeyboardRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-KINPUTVIEW_HEIGHT, [UIScreen mainScreen].bounds.size.width, (KINPUTVIEW_HEIGHT+KASSIGANTVIEW_HEIGHT));
        _showkeyboardRect = _hiddenKeyboardRect;
        self.frame = _hiddenKeyboardRect;
        self.backgroundColor = [UIColor whiteColor];
        [self initInputView];
        [self addSubviewsAndAutoLayout];
        [self registerForKeyboardNotifications];
    }
    return self;
}
#pragma mark Layoutsubviews
- (void)initInputView{
    _chatInputView = [[UIView alloc]init];
    // 键盘隐藏的frame
    // FIX ME 以后修改成约束
    
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
    [_messageBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _moreItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreItemBtn setBackgroundColor:[UIColor orangeColor]];
    [_moreItemBtn addTarget:self action:@selector(moreItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emojiBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
    [_emojiBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
    [_emojiBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
    [_emojiBtn addTarget:self action:@selector(emojiAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentTextView = [[UITextView alloc]init];
    _contentBackground = [[UIImageView alloc]init];
  //  _contentBackground.image = [UIImage imageNamed:@"Action_Sheet_Normal_New"];
    // FIX ME 以后修改四角适配
    _contentBackground.backgroundColor = [UIColor lightGrayColor];
    _contentBackground.layer.cornerRadius = 5;
    _contentTextView.font = [UIFont systemFontOfSize:KCONTENT_FONT];
    _contentTextView.delegate = self;
    _contentTextView.returnKeyType = UIReturnKeySend;
    
    _faceBoard = [[FaceBoard alloc] init];
    _faceBoard.inputTextView = _contentTextView;
    
    _assistanceView = [[ChatAssistanceView alloc] init];
    _assistanceView.assistanceText = _contentTextView;

    _talkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_talkBtn setTitle:@"按住说话" forState:UIControlStateNormal];
    [_talkBtn setTitle:@"松开结束" forState:UIControlStateHighlighted];
    [_talkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_talkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [_talkBtn addTarget:self action:@selector(beginRecordVioce:) forControlEvents:UIControlEventTouchDown];
    [_talkBtn addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    [_talkBtn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [_talkBtn addTarget:self action:@selector(remindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_talkBtn addTarget:self action:@selector(remindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    
    [_talkBtn setHidden:TRUE];
}

- (void)addSubviewsAndAutoLayout{
    [self addSubview:_chatInputView];
    [_contentView addSubview:_contentBackground];
    [_contentView addSubview:_talkBtn];
    [_contentView addSubview:_contentTextView];
    [_chatInputView addSubview:_messageBtn];
    [_chatInputView addSubview:_moreItemBtn];
    [_chatInputView addSubview:_emojiBtn];
    [_chatInputView addSubview:_contentView];
    [_chatInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.and.right.offset(0);
        make.height.equalTo(@(KINPUTVIEW_HEIGHT));
    }];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.offset(KGAP*2);
        make.height.and.width.equalTo(@(KBUTTON_SIZE));
    }];
    [_moreItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageBtn);
        make.height.and.width.equalTo(@(KBUTTON_SIZE));
        make.right.equalTo(_chatInputView).offset(-KGAP);
    }];
    [_emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageBtn);
        make.height.and.width.equalTo(@(KBUTTON_SIZE));
        make.right.equalTo(_moreItemBtn.mas_left).offset(-KGAP*2);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chatInputView).offset(KGAP);
        make.height.equalTo(@(KBUTTON_SIZE+2*KGAP));
        make.left.equalTo(_messageBtn.mas_right).offset(KGAP*2);
        make.right.equalTo(_emojiBtn.mas_left).offset(-KGAP*2);
    }];
    UIEdgeInsets padding = UIEdgeInsetsMake(3, KGAP, 3, KGAP);
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.with.insets(padding);
        
    }];
    UIEdgeInsets talkPadding = UIEdgeInsetsMake(KGAP, KGAP, KGAP, KGAP);
    [_talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.with.insets(talkPadding);
    }];
    
    [_contentBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
}
#pragma mark 注册通知
- (void)registerForKeyboardNotifications{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
#pragma mark 键盘显示的监听方法
-(void)keyboardWillShow:(NSNotification *)notif
{
 
    if ([_observer respondsToSelector:@selector(chatKeyboardWillShow)]) {
        [_observer chatKeyboardWillShow];
    }

    // 获取键盘的位置和大小
    CGRect keyboardBounds;
    [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notif.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGFloat height = _hiddenKeyboardRect.origin.y - keyboardBounds.size.height;
    if (height == 0) {
        return;
    }
    _showkeyboardRect.origin.y = height;
    //  NSLog(@"duration = %g",[duration doubleValue] );
    // 动画改变位置
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve doubleValue]];
        self.frame = _showkeyboardRect;
        // 更改输入框的位置
    }];

    
}

#pragma mark 键盘隐藏的监听方法
-(void) keyboardWillHide:(NSNotification *) note
{
    if ([_observer respondsToSelector:@selector(chatKeyboardWillHide)]) {
        [_observer chatKeyboardWillHide];
    }

    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 动画改变位置
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        // 更改输入框的位置
        _showkeyboardRect = _hiddenKeyboardRect;
        self.frame = _hiddenKeyboardRect;

    }];
}


#pragma mark Button_Action
- (void)messageAction:(UIButton *)sender{
    if (sender.selected) {
        // 语音输入
        _contentTextView.hidden = FALSE;
        _talkBtn.hidden = TRUE;
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        [self setKeyboardHidden:FALSE];
        //选中状态事件
    }else{
        // 文字输入
        _contentTextView.hidden = TRUE;
        _talkBtn.hidden = FALSE;
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        [self setKeyboardHidden:TRUE];
        //未选中状态事件
    }
    sender.selected = !sender.selected;
}

- (void)moreItemAction:(UIButton *)sender{
    if (sender.selected) {
        [_contentTextView resignFirstResponder];
        _contentTextView.inputView = nil;
        [_contentTextView becomeFirstResponder];
    }else{
        [_contentTextView resignFirstResponder];
        _contentTextView.inputView = _assistanceView;
        [_contentTextView becomeFirstResponder];
    }
     _contentTextView.hidden = FALSE;
    _emojiBtn.selected = FALSE;
    _messageBtn.selected = FALSE;
    sender.selected = !sender.selected;
}

- (void)emojiAction:(UIButton *)sender{
    if (sender.selected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        [_contentTextView resignFirstResponder];
        _contentTextView.inputView = nil;
        [_contentTextView becomeFirstResponder];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        [_contentTextView resignFirstResponder];
        _contentTextView.inputView = _faceBoard;
        [_contentTextView becomeFirstResponder];
    }
    _contentTextView.hidden = FALSE;
    _moreItemBtn.selected = FALSE;
    _messageBtn.selected = FALSE;
    sender.selected = !sender.selected;
}

#pragma mark 开始录音
- (void)beginRecordVioce:(UIButton *)button{
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    // 录音设置
    NSMutableDictionary *recordSetting = [NSMutableDictionary dictionary];
    // 设置录音格式
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    // 设置采样率
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    // 录音通道
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    // 线性采样率
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    // 录音质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/arm.wav"];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:recordSetting error:nil];
    self.recorder.delegate = self;
    [self.recorder prepareToRecord];
    [self.recorder record];
    
    self.recordTime = 0;
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    [UUProgressHUD dismissWithSuccess:nil];
    [self.recorder stop];
}

- (void)cancelRecordVoice:(UIButton *)button
{
    [self.recorder stop];
    [self.recorder deleteRecording];
    [UUProgressHUD dismissWithError:@"取消"];
}

- (void)remindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"松开手指,取消发送"];
}

-(void)countVoiceTime
{
    self.recordTime += 0.5;
    if (self.recordTime >= 60) {
        [self.recorder stop];
    }
}

- (void)remindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"向上滑动取消"];
}

#pragma AVAudioRecordDeleagte
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
 
    if (self.recordTime < 0.5) {
        [UUProgressHUD dismissWithError:@"时间太短"];
        [self.recordTimer invalidate];
        self.recordTimer = nil;
        return;
    }

    if (flag) {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/arm.wav"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (_observer && [_observer respondsToSelector:@selector(sendSoundWithData:)]) {
            [_observer sendSoundWithData:data];
        }
        
    }else{
        [UUProgressHUD dismissWithSuccess:@"录音失败"];
    }
    [self.recordTimer invalidate];
    self.recordTimer = nil;
}

#pragma mark Public
- (void)setKeyboardHidden:(BOOL)hidden{
    if(hidden){
        [_contentTextView resignFirstResponder];
        _emojiBtn.selected = FALSE;
        _messageBtn.selected =FALSE;
        _moreItemBtn.selected = FALSE;
    }else{
        [_contentTextView becomeFirstResponder];
    }
}
#pragma mark Private

#pragma mark TextView_Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
    
        if ([_observer respondsToSelector:@selector(sendMessageWithText:)]) {
            [_observer sendMessageWithText:textView.text];
        }
           textView.text = nil;
        return NO;
    }
    return YES;
}
#pragma mark 释放对象
- (void)dealloc{
    _observer = nil;
    [[NSNotificationCenter defaultCenter]  removeObserver:self forKeyPath:UIKeyboardWillHideNotification];
    [[NSNotificationCenter defaultCenter]  removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
}
@end
