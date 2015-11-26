//
//  ChatAssistanceView.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/21.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "ChatAssistanceView.h"
#import "ChatAssistanceModel.h"

#define CHARTASSISTACED @"ChatResourse"

#define SCREENWIDTH  ( [UIScreen mainScreen].bounds.size.width )

#define SCREENHEIGHT ( [UIScreen mainScreen].bounds.size.height)

#define CHATASSISTANCE_COUNT_ROW 2 // 行数

#define CHATASSISTANCE_COUNT_CLU 4 // 每行个数

#define CHATASSISTANCE_ITEM_SIZE 68 * SCREENHEIGHT / 667

#define CHATASSISTANCE_COUNT_PAGE (CHATASSISTANCE_COUNT_ROW * CHATASSISTANCE_COUNT_CLU)

#define ITEM_DISTANCE_SIZE 20 * SCREENWIDTH / 375
@interface ChatAssistanceView ()<UIScrollViewDelegate>{
    UIScrollView *chatAssistanceScrollView;
    GrayPageControl *assistancePageControl;
    ChatAssistanceModel *assistanceM;
    NSMutableArray *assistanceItemArray;
}

@end

@implementation ChatAssistanceView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self getAssistancePagecontrol];
        [self layOutSubView];
    }
    return self;
}

#pragma mark privite getAssistanceDic
- (void) getAssistancePagecontrol
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource: CHARTASSISTACED ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSError *error;
    assistanceM = [[ChatAssistanceModel alloc] initWithDictionary:dic error:&error];
    assistanceItemArray = [NSMutableArray array];
    for (ChatAssistanceitemModel *assistanceItem in assistanceM.moreItems) {
        [assistanceItemArray addObject:assistanceItem];
    }
}

#pragma mark privite layOutSubviews
- (void) layOutSubView
{
    chatAssistanceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190)];
    chatAssistanceScrollView.pagingEnabled = YES;
    chatAssistanceScrollView.contentSize = CGSizeMake((assistanceItemArray.count / CHATASSISTANCE_COUNT_PAGE + 1) * SCREENWIDTH, 190);
    chatAssistanceScrollView.showsHorizontalScrollIndicator = NO;
    chatAssistanceScrollView.showsVerticalScrollIndicator = NO;
    chatAssistanceScrollView.delegate = self;
    
    for (int i = 0; i < assistanceItemArray.count; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton addTarget:self action:@selector(itemButton:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat x = ITEM_DISTANCE_SIZE * (i % 4 + 1) + (i % 4) * CHATASSISTANCE_ITEM_SIZE + SCREENWIDTH * (i / 8);
        CGFloat y;
        if (i / 4 % 2 == 0) {
        y = ITEM_DISTANCE_SIZE;
        }else{
        y = CHATASSISTANCE_ITEM_SIZE + 2 * ITEM_DISTANCE_SIZE;
        }
        itemButton.frame = CGRectMake(x, y, CHATASSISTANCE_ITEM_SIZE, CHATASSISTANCE_ITEM_SIZE);
        [itemButton setBackgroundImage:[UIImage imageNamed:[[assistanceItemArray objectAtIndex:i] iconButtonBcakImage]] forState:UIControlStateNormal];
        itemButton.backgroundColor = [UIColor redColor];
        [chatAssistanceScrollView addSubview:itemButton];
    }
    assistancePageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(130, 190, 100, 20)];
    [assistancePageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    assistancePageControl.numberOfPages = assistanceItemArray.count / CHATASSISTANCE_COUNT_PAGE + 1;
    assistancePageControl.currentPage = 0;
    [self addSubview:assistancePageControl];
    [self addSubview:chatAssistanceScrollView];
    
}

#pragma mark SCrollViewDelagate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [assistancePageControl setCurrentPage:(chatAssistanceScrollView.contentOffset.x / SCREENWIDTH)];
    [assistancePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {
    [chatAssistanceScrollView setContentOffset:CGPointMake(assistancePageControl.currentPage * SCREENWIDTH, 0) animated:YES];
    [assistancePageControl setCurrentPage:assistancePageControl.currentPage];
}

- (void)itemButton:(id)sender {
    NSLog(@"click item");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
