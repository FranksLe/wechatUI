//
//  CSChatTableView.m
//  CSChatDemo
//
//  Created by XiaoSong on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatTableView.h"

@implementation CSChatTableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.allowsSelection = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}
@end
