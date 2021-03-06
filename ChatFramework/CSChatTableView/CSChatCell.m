//
//  CSChatCell.m
//  CSChatDemo
//
//  Created by XiaoSong on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatCell.h"
#import "CSChatModel.h"
#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度

#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

#define kContentTop 10 //文本内容与按钮上边缘间隔
#define kContentLeft 25 //文本内容与按钮左边缘间隔
#define kContentBottom 15 //文本内容与按钮下边缘间隔
#define kContentRight 15 //文本内容与按钮右边缘间隔
#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体
@implementation CSChatCell{
    UIButton *_timeBtn;
    UIImageView *_iconView;
    UIButton *_contentBt;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self layOutSubviewss];
    }
    return self;
    
}
#pragma mark privite LayOutSubView
- (void)layOutSubviewss
{
    _timeBtn = [[UIButton alloc] init];
    [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = kTimeFont;
    _timeBtn.enabled = NO;
    [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:_timeBtn];
    
    // 2、创建头像
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    
    // 3、创建内容
    _contentBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_contentBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _contentBt.titleLabel.font = kContentFont;
    _contentBt.titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_contentBt];
}
- (void)loadViewModel:(CSChatCellViewModel *)viewModel{
    _viewModel = viewModel;
    
    [_timeBtn setTitle:viewModel.time forState:UIControlStateNormal];
    
    _timeBtn.frame = viewModel.timeF;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:viewModel.icon];
    _iconView.frame = viewModel.iconF;
    
    // 3、设置内容
    [_contentBt setTitle:viewModel.content forState:UIControlStateNormal];
    _contentBt.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBt.frame = viewModel.contentF;
    
    if (viewModel.type == 0) {
        _contentBt.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
    UIImage *normal , *focused;
    if (viewModel.type == 0) {
        
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        
    }
    [_contentBt setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBt setBackgroundImage:focused forState:UIControlStateHighlighted];
}
@end
