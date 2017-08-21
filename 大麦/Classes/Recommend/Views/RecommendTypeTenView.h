//
//  RecommendTypeTenView.h
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendListSubModel.h"
#import "RecommendListModel.h"
@interface RecommendTypeTenView : UIView
@property (strong, nonatomic) RecommendListModel *listModel;
@end

@interface RecommendTypeTenViewCell : UICollectionViewCell
@property (strong, nonatomic) RecommendListSubModel *model;
@end
