//
//  ViewController.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "CSChatViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)chat:(UIButton *)sender {
    CSChatViewController *vc = [[CSChatViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
