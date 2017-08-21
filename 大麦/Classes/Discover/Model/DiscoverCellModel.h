//
//  DiscoverCellModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverCellModel : NSObject
@property (copy, nonatomic) NSString *templateType;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *specialColId;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *listViewPic;
@property (copy, nonatomic) NSString *favourCount;
@property (copy, nonatomic) NSString *readingNum;
@end
