//
//  CSChatCell.h
//  CSChatDemo
//
//  Created by XiaoSong on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChatCellViewModel.h"
@interface CSChatCell : UITableViewCell
@property (strong ,nonatomic) CSChatCellViewModel *viewModel;
- (void)loadViewModel:(CSChatCellViewModel *)viewModel;
@end
