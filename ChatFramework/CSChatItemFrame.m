//
//  CSChatItemFrame.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/24.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatItemFrame.h"
#define kMargin 10 // 间隔
#define KIconWH 40 // 头像高度
#define KContentW 180 // 内容宽度

#define KTimeMarginW 15
#define KTimeMarginH 10

#define KContentTop 10
#define KcontentLeft 25
#define KContentBottom 15
#define KContentRight 15

#define KTimeFont [UIFont systemFontOfSize:12]
#define KContentFont [UIFont systemFontOfSize:16]


@implementation CSChatItemFrame

- (void)setMessage:(CSChatVIewItemModel *)message
{
    _message = message;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    if (_showTime) {
        CGFloat timeY = kMargin;
        CGSize timeSize = [_message.time sizeWithFont:KTimeFont];
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + KTimeMarginW, timeSize.height + KTimeMarginH);
    }
    CGFloat iconX = kMargin;
    if (_message.type == 0) {
        iconX = screenW - kMargin - KIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, KIconWH, KIconWH);
    
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGSize contentSize = [_message.content sizeWithFont:KContentFont constrainedToSize:CGSizeMake(KContentW, CGFLOAT_MAX)];
    
    if (_message.type == 0) {
        contentX = iconX - kMargin - contentSize.width - KcontentLeft - KContentRight;
    }
    
    _contentF = CGRectMake(contentX, contentY, contentSize.width + KcontentLeft + KContentRight, contentSize.height + KContentTop + KContentBottom);
    
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
    
}


@end
