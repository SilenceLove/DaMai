//
//  SelectCityViewController.h
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "BaseViewController.h"

@protocol SelectCityViewControllerDelegate <NSObject>

- (void)didSelectCityClick:(SelectCityModel *)model;

@end

@interface SelectCityViewController : BaseViewController
@property (weak, nonatomic) id<SelectCityViewControllerDelegate> delegate;
@end
