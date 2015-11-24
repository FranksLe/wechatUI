//
//  ChatAssistanceModel.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/23.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class ChatAssistanceitemModel;
@protocol ChatAssistanceitemModel <NSObject>
@end

@interface ChatAssistanceitemModel : JSONModel
@property (copy ,nonatomic) NSString *iconTitle;
@property (copy ,nonatomic) NSString *iconButtonBcakImage;
@end

@interface ChatAssistanceModel : JSONModel
@property (strong ,nonatomic) NSArray<ChatAssistanceitemModel> *moreItems;
@property (copy ,nonatomic) NSString *moreIconName;
@property (copy ,nonatomic) NSString *emjoIconName;
@property (copy ,nonatomic) NSString *contentBackgroundImageName;
@property (copy ,nonatomic) NSString *keyboardIconName;
@property (copy ,nonatomic) NSString *soundIconName;

@end


