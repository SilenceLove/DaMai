//
//  ViewModelProtocol.h
//  他趣
//
//  Created by 洪欣 on 16/12/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"
typedef enum : NSUInteger {
    HeaderRefresh_HasMoreData = 1,
    HeaderRefresh_HasNoMoreData,
    FooterRefresh_HasMoreData,
    FooterRefresh_HasNoMoreData,
    RefreshError,
    RefreshUI,
} RefreshDataStatus;


@protocol ViewModelProtocol <NSObject>
- (instancetype)initWithModel:(id)model;

@property (strong, nonatomic)HttpTool *request;

- (void)initialize;
@end
