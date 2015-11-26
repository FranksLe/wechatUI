//
//  FaceBoard.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "FaceBoard.h"

#import <Masonry/Masonry.h>

#define FACE_COUNT_ALL 85

#define FACE_COUNT_ROW 4

#define FACE_COUNT_CLU 8

#define FACE_COUNT_PAGE (FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE 44

#define SCREENWIDTH  ( [UIScreen mainScreen].bounds.size.width )

#define SCREENHEIGHT ( [UIScreen mainScreen].bounds.size.height)

@interface FaceBoard ()<UIScrollViewDelegate>{
    UIScrollView *faceView;
    GrayPageControl *facePageControl;
    NSDictionary *_faceMap;
}

@end

@implementation FaceBoard

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:236.0/ 255.0 green:236.0/255.0 blue:236.0 / 255.0 alpha:1];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        if ([[languages objectAtIndex:0] hasPrefix:@"zh"]) {
            _faceMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"_expression_cn" ofType:@"plist"]];
        }else{
          _faceMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"_expression_en" ofType:@"plist"]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:_faceMap forKey:@"FaceMap"];
        // 表情盘
        faceView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190)];
        faceView.pagingEnabled = YES;
        faceView.contentSize = CGSizeMake((FACE_COUNT_ALL / FACE_COUNT_PAGE + 1) * SCREENWIDTH, 190);
        faceView.showsHorizontalScrollIndicator = NO;
        faceView.showsVerticalScrollIndicator = NO;
        
        self.faceString = [NSMutableString string];
        for (int i = 1; i <= FACE_COUNT_ALL; i++) {
            UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [faceButton addTarget:self action:@selector(faceButton:) forControlEvents:UIControlEventTouchUpInside];
            faceButton.tag = i;
            CGFloat x = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + ((i - 1) / FACE_COUNT_PAGE * SCREENWIDTH);
            CGFloat y = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * FACE_ICON_SIZE + 8;
            faceButton.frame = CGRectMake( x, y, FACE_ICON_SIZE, FACE_ICON_SIZE);
            
            [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d", i]]
                        forState:UIControlStateNormal];
            [faceView addSubview:faceButton];
        }
        //添加PageControl
        facePageControl = [[GrayPageControl alloc]initWithFrame:CGRectMake(130, 190, 100, 20)];
        [facePageControl addTarget:self
                            action:@selector(pageChange:)
                  forControlEvents:UIControlEventValueChanged];
        
        facePageControl.numberOfPages = FACE_COUNT_ALL / FACE_COUNT_PAGE + 1;
        facePageControl.currentPage = 0;
        [self addSubview:facePageControl];
        
        //添加键盘View
        [self addSubview:faceView];
        
        //删除键
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"删除" forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"del_emoji_normal"] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"del_emoji_select"] forState:UIControlStateSelected];
        [back addTarget:self action:@selector(backFace) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(SCREENWIDTH - 50, SCREENHEIGHT - 50, 38, 28);
        [faceView addSubview:back];
    }
    return self;
}
//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [facePageControl setCurrentPage:faceView.contentOffset.x / SCREENWIDTH];
    [facePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {
    
    [faceView setContentOffset:CGPointMake(facePageControl.currentPage * SCREENWIDTH, 0) animated:YES];
    [facePageControl setCurrentPage:facePageControl.currentPage];
}

- (void)faceButton:(id)sender {
    NSInteger i = ((UIButton *)sender).tag;
    [self.faceString appendString:[_faceMap objectForKey:[NSString stringWithFormat:@"%03ld", (long)i]]];
    [self.FaceDelegate clickFaceBoard:self.faceString];
}

- (void)backFace{
   

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
