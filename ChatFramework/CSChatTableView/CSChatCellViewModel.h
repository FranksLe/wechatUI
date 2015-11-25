//
//  CSChatCellViewModel.h
//  CSChatDemo
//
//  Created by XiaoSong on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CSChatModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CSChatCellViewModel : NSObject
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *time;
@property (nonatomic ,assign) NSInteger type;
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic ,assign,getter = isvisableDate ) BOOL visableDate;

- (instancetype)initWithModel:(CSChatVIewItemModel *)model;
@end
