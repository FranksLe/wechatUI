//
//  CSChatItemFrame.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/24.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSChatModel.h"
@interface CSChatItemFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign) BOOL showTime;

@property (nonatomic ,strong) CSChatVIewItemModel *message;

@end
