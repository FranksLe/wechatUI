//
//  CSChatViewController.m
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatToolView.h"
#import "CSChatViewController.h"
#import <Masonry/Masonry.h>
@interface CSChatViewController ()<CSChatToolViewKeyboardProtcol>
@property (strong ,nonatomic) CSChatToolView *chatView;
@end

@implementation CSChatViewController
#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
         _chatView = [[CSChatToolView alloc]initWithObserver:self];
        [self.view addSubview:_chatView];
    }
    return self;
}
#pragma mark CSChatToolView_Delegate
- (void)chatKeyboardWillShow{
    
}
- (void)chatKeyboardWillHide{
    
}
- (void)sendMessageWithText:(NSString *)text{
    NSLog(@"输入的内容 = %@",text);
}
#pragma mark AutoLayout

#pragma mark activity
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark layoutsubviews



@end
