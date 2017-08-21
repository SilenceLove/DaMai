//
//  RecommendMiddleView.h
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendListModel;
@interface RecommendMiddleView : UIView
@property (strong, nonatomic) RecommendListModel *model;
@end

@class RecommendListSubModel;
@interface RecommendMiddleViewCell : UICollectionViewCell
@property (strong, nonatomic) RecommendListSubModel *model;
@property (copy, nonatomic) void(^didCell)(UICollectionViewCell *cell);
@end
