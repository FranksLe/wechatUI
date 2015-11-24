//
//  CSChatVIewModel.m
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatVIewModel.h"
#import "CSChatModel.h"
#define CSCHAT_PLIST_FILENAME @"ChatContent"

@implementation CSChatVIewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:CSCHAT_PLIST_FILENAME ofType:@"plist"];
        NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSError *error;
        _cSChatContentArray = [NSMutableArray array];
        CSChatModel *model = [[CSChatModel alloc] initWithDictionary:dic error:&error];
        for (CSChatVIewItemModel *models in model.chatContent) {
            [_cSChatContentArray addObject:models];
        }
    }
    return self;
}

@end
