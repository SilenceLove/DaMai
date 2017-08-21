//
//  RecommendCouponsView.h
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendListSubModel.h"
#import "RecommendListModel.h"

@interface RecommendCouponsView : UIView
@property (strong, nonatomic) RecommendListModel *listModel;
@end

@interface RecommendCouponsViewCell : UICollectionViewCell
@property (strong, nonatomic) RecommendListSubModel *model;
@end
