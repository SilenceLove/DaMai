//
//  DiscoverHeaderSubModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverHeaderSubOneModel : NSObject
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (copy, nonatomic) NSString *isShowTitle;
@property (copy, nonatomic) NSArray *scrollItems;
@property (copy, nonatomic) NSArray *seckillItems;
@property (copy, nonatomic) NSArray *specialColPack;
@end
