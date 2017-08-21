//
//  RecommendHeaderView.h
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecommendHeaderViewDelegate <NSObject>

- (void)cycleScrollViewDidScrollViewToIndexforUrl:(NSString *)url;

@end

@class RecommendListModel;
@interface RecommendHeaderView : UIView

@property (weak, nonatomic) id<RecommendHeaderViewDelegate> delegate;
@property (copy, nonatomic) NSArray *headerList;
@property (copy, nonatomic) NSArray *shufflingAy;
@property (copy, nonatomic) NSArray *typeAy;
@property (copy, nonatomic) NSArray *headlines;
@property (copy, nonatomic) NSArray *rNewList;

@end
