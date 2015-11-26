//
//  CSChatViewController.m
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//


#import "CSChatViewController.h"
#import <Masonry/Masonry.h>
#import "CSChatCell.h"



@implementation CSChatViewController
#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
         _chatView = [[CSChatToolView alloc]initWithObserver:self];
        [self layOutsubviews];
    }
    return self;
}

#pragma mark privite LayoutSubView

- (void) layOutsubviews
{
    _chatTableView = [[CSChatTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50) style:UITableViewStylePlain];
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //fix me 修改成约束布局
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
    _viewModel = [[CSChatVIewModel alloc] init];
    
    [self.view addSubview:_chatTableView];
    [self.view addSubview:_chatView];
}

#pragma mark UITableViewDelagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CSChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CSChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell loadViewModel:self.viewModel.cellViewModels[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel.cellViewModels[indexPath.row] cellHeight];
}


#pragma mark CSChatToolView_Delegate
- (void)chatKeyboardWillShow{
    
}
- (void)chatKeyboardWillHide{
    
}
- (void)sendMessageWithText:(NSString *)text{
    NSLog(@"输入的内容 = %@",text);
}
#pragma mark AutoLayout

#pragma mark activity
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark layoutsubviews



@end
