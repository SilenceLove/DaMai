//
//  RecommendNewView.h
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendListModel.h"
@interface RecommendNewView : UIView
@property (copy, nonatomic) NSArray *list;
@property (strong, nonatomic) RecommendListModel *model;
@end
