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
#import <ReactiveCocoa/ReactiveCocoa.h>
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
    [self autoRollToLastRow];
    UITapGestureRecognizer *tapReturnKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKeyBoard:)];
    [_chatTableView addGestureRecognizer:tapReturnKeyBoard];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel.cellViewModels[indexPath.row] cellHeight];
}

#pragma mark CSChatToolView_Delegate
- (void)chatKeyboardWillShow:(CGFloat)keyBoardHeight{
    [UIView animateWithDuration:0.4 animations:^{
     [_chatTableView setFrame:CGRectMake(_chatTableView.frame.origin.x, 0 - keyBoardHeight, _chatTableView.frame.size.width, _chatTableView.frame.size.height)];
    }];
}
- (void)chatKeyboardWillHide{
    [UIView animateWithDuration:0.4 animations:^{
        [_chatTableView setFrame:CGRectMake(_chatTableView.frame.origin.x, 0, _chatTableView.frame.size.width, _chatTableView.frame.size.height)];
    }];
}
- (void)sendMessageWithText:(NSString *)text{
    NSLog(@"输入的内容 = %@",text);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    formatter.dateFormat = @"MM-dd HH:mm";
    NSString *time = [formatter stringFromDate:date];
    [self addMessageWithContent:text time:time];
    [_chatTableView reloadData];
    [_chatTableView scrollRectToVisible:CGRectMake(0, _chatTableView.contentSize.height - 15, _chatTableView.frame.size.width, 10) animated:YES];
}

#pragma mark 给数据源增加内容
- (void)addMessageWithContent:(NSString *)content time:(NSString *)time
{
    CSChatCellViewModel *cschatViewM = [[CSChatCellViewModel alloc] init];
    cschatViewM.content = content;
    cschatViewM.time = time;
    cschatViewM.icon = @"iconHead1";
    cschatViewM.type = 0;
    [self.viewModel.cellViewModels addObject:cschatViewM];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_chatView.contentTextView resignFirstResponder];
}
#pragma mark private click tableview
- (void)returnKeyBoard:(id)sender
{
    [_chatView.contentTextView resignFirstResponder];
}

#pragma mark tableview自动滚动到最后一行
- (void)autoRollToLastRow
{
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_viewModel.cellViewModels.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark AutoLayout

#pragma mark activity
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark layoutsubviews



@end
