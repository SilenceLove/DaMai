//
//  ShowChildScrollView.h
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowChildScrollViewDelegate <NSObject>

- (void)scrollViewEndSlideWithIndex:(NSInteger)index;

@end

@interface ShowChildScrollView : UIScrollView

@property (weak, nonatomic) id<ShowChildScrollViewDelegate> myDelegate;

- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)children MaxCount:(NSInteger)maxCount;

- (void)scrollViewWithIndex:(NSInteger)index;
@end
