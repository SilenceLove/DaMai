//
//  RecommendListModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendListModel : NSObject

@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *list;
@property (copy, nonatomic) NSString *subTitle;
@property (assign, nonatomic) CGFloat height;

@end
