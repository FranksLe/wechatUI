//
//  CSChatVIewModel.h
//  CSChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CSChatCellViewModel.h"
#import <Foundation/Foundation.h>
@interface CSChatVIewModel : NSObject
@property (nonatomic ,strong , readonly) NSMutableArray <CSChatCellViewModel *>*cellViewModels;

@end
