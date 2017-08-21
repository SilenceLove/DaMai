//
//  BaseCollectionReusableView.m
//  他趣
//
//  Created by 洪欣 on 16/12/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@implementation BaseCollectionReusableView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (void)setupViews {}

- (void)bindViewModel {}

@end
