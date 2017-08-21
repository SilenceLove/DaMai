//
//  ViewProtocol.h
//  他趣
//
//  Created by 洪欣 on 16/12/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelProtocol.h"

@protocol ViewModelProtocol;

@protocol ViewProtocol <NSObject>
- (instancetype)initWithViewModel:(id <ViewModelProtocol>)viewModel;

- (void)bindViewModel;
- (void)setupViews;
@end
