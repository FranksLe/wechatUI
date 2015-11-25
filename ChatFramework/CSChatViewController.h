//
//  CSChatViewController.h
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChatVIewModel.h"
#import "CSChatToolView.h"
#import "CSChatTableView.h"
@interface CSChatViewController : UIViewController<CSChatToolViewKeyboardProtcol, UITableViewDataSource, UITableViewDelegate>
@property (strong ,nonatomic) CSChatToolView *chatView;
@property (strong ,nonatomic) CSChatTableView *chatTableView;
@property (strong ,nonatomic) CSChatVIewModel *viewModel;
@end
