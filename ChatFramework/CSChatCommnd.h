//
//  CSChatCommnd.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSChatCommnd : NSObject
+ (instancetype)standardChatDefaults;

- (void)sendMessageWithText:(NSString *)text;
- (void)sendMessageWithSound;

@end
