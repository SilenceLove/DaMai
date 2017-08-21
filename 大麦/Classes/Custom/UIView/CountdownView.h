//
//  CountdownView.h
//  大麦
//
//  Created by 洪欣 on 17/1/14.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountdownViewDelegate <NSObject>

- (void)countdownComplete;

@end

@interface CountdownView : UIView
@property (weak, nonatomic) id<CountdownViewDelegate> delegate;
@property (copy, nonatomic) NSString *timeStr;
@end
