//
//  CSChatCommnd.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatCommnd.h"

@implementation CSChatCommnd
+ (instancetype)standardChatDefaults{
    static CSChatCommnd *commnd = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commnd = [[CSChatCommnd alloc]init];
    });
    return commnd;
}
- (void)sendMessageWithText:(NSString *)text{
    NSLog(@"发送消息");
}
- (void)sendMessageWithSound{
    
}
@end
