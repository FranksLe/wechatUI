//
//  FaceBoard.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayPageControl.h"
#define FACE_NAME_HEAD @"/s"
#define FACE_NAME_LEN 5// 表情转义字符的长度

@protocol FaceBoardDelegate <NSObject>

@optional


@end

@interface FaceBoard : UIView

@property (nonatomic, strong) UITextView *inputTextFiel;
@property (nonatomic, strong) UITextView *inputTextView;
-(void)backFace;

@end
