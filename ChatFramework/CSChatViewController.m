//
//  CSChatViewController.m
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CSChatToolView.h"
#import "CSChatViewController.h"
#import <Masonry/Masonry.h>
#import "CSChatVIewModel.h"
#import "CSChatItemFrame.h"
#import "CSChatItemsView.h"
@interface CSChatViewController ()<CSChatToolViewKeyboardProtcol, UITableViewDataSource, UITableViewDelegate>
@property (strong ,nonatomic) CSChatToolView *chatView;
@property (strong ,nonatomic) UITableView *chatTableView;
@property (strong ,nonatomic) CSChatVIewModel *viewModel;
@property (strong ,nonatomic) NSMutableArray *array;
@end

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
    _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50) style:UITableViewStylePlain];
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatTableView.allowsSelection = NO;
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
    _array = [NSMutableArray array];
    _viewModel = [[CSChatVIewModel alloc] init];
    NSString *previousTime = nil;
    for (int i = 0; i < _viewModel.cSChatContentArray.count; i++) {
        CSChatItemFrame *messageFrame = [[CSChatItemFrame alloc] init];
        messageFrame.showTime = ![previousTime isEqualToString:[[_viewModel.cSChatContentArray objectAtIndex:i] time]];
        messageFrame.message = [_viewModel.cSChatContentArray objectAtIndex:i];
        [_array addObject:messageFrame];
    }
    [self.view addSubview:_chatTableView];
    [self.view addSubview:_chatView];
}

#pragma mark UITableViewDelagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CSChatItemsView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CSChatItemsView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.messageFrame = _array[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_array[indexPath.row] cellHeight];
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
