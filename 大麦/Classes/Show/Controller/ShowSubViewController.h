//
//  ShowSubViewController.h
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "BaseViewController.h"

@class ShowRequestModel;
@interface ShowSubViewController : BaseViewController
@property (weak, nonatomic) UITableView *tableView;

- (void)loadData:(ShowRequestModel *)model Complete:(void(^)())complete;

@end
