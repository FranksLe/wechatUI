//
//  CSChatModel.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/24.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class CSChatVIewItemModel;
@protocol CSChatVIewItemModel <NSObject>
@end

@interface CSChatVIewItemModel : JSONModel
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *time;
@property (nonatomic ,assign) NSInteger type;

@end

@interface CSChatModel : JSONModel
@property (nonatomic ,strong) NSArray<CSChatVIewItemModel> *chatContent;
@end
