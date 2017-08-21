//
//  IntroductionSubModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroductionSubOneModel.h"
#import "IntroductionSubThreeModel.h"
@interface IntroductionSubModel : NSObject
@property (strong, nonatomic) IntroductionSubOneModel *Venue;
@property (copy, nonatomic) NSString *ProjDesc;
@property (copy, nonatomic) NSArray *ArtistList;
@property (copy, nonatomic) NSArray *ReviewList;
@property (copy, nonatomic) NSString *ReviewCount;
@property (copy, nonatomic) NSArray *ProjectQA;
@property (copy, nonatomic) NSString *ProjQACount;
@property (copy, nonatomic) NSString *CategoryID;
@property (copy, nonatomic) NSString *IsSub;
@property (copy, nonatomic) NSString *ProjCommentCount;
@property (copy, nonatomic) NSDictionary *projPane;
@property (copy, nonatomic) NSString *openSum;
@property (copy, nonatomic) NSString *collectionSum;
@property (copy, nonatomic) NSArray *projPromotions;
@property (strong, nonatomic) IntroductionSubThreeModel *basicInfo;
@end
