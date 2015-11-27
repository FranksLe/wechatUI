//
//  CSChatToolView.h
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSChatToolView;
@protocol CSChatToolViewKeyboardProtcol <NSObject>
@optional
- (void)chatKeyboardWillShow:(CGFloat)keyBoardHeight;
- (void)chatKeyboardWillHide;
- (void)sendMessageWithText:(NSString *)text;
- (void)sendSoundWithData:(NSData *)data;
@end
@interface CSChatToolView : UIView

@property (strong ,nonatomic) UITextView *contentTextView;
- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;
/**
 * @brief 初始化toolView并设计观察对象
 * @return toolview实例对象
 */
- (instancetype)initWithObserver:(NSObject<CSChatToolViewKeyboardProtcol> *)object;
/**
 * @brief 是否隐藏键盘
 */
- (void)setKeyboardHidden:(BOOL)hidden;
@end
