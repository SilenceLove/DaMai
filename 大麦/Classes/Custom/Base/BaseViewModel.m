//
//  BaseViewModel.m
//  他趣
//
//  Created by 洪欣 on 16/12/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (HttpTool *)request
{
    if (!_request) {
        _request = [[HttpTool alloc] init];
    }
    return _request;
}

- (void)initialize
{
}

@end
