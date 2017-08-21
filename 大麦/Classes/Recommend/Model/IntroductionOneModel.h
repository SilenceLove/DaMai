//
//  IntroductionOneModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroductionOneModel : NSObject
@property (copy, nonatomic) NSString *i;
@property (copy, nonatomic) NSString *n;
@property (copy, nonatomic) NSString *p;
@property (copy, nonatomic) NSString *t;
@property (copy, nonatomic) NSString *s;
@property (copy, nonatomic) NSString *VenId;
@property (copy, nonatomic) NSString *VenName;
@property (assign, nonatomic) BOOL IsXuanZuo;
@property (assign, nonatomic) BOOL IsToBeAboutTo;
@property (assign, nonatomic) BOOL IsBuyRightNow;
@property (assign, nonatomic) BOOL IsOpenNotice;
@property (copy, nonatomic) NSString *CategoryID;
@property (copy, nonatomic) NSString *Seating;
@property (copy, nonatomic) NSString *CityName;
@property (copy, nonatomic) NSString *CityId;
@property (copy, nonatomic) NSString *isClient;
@property (copy, nonatomic) NSString *PrivilegeType;
@property (copy, nonatomic) NSString *IsGeneralAgent;
@property (assign, nonatomic) BOOL IsB2B2C;
@property (copy, nonatomic) NSString *StatusDescn;
@property (assign, nonatomic) BOOL showResrvButton;
@property (assign, nonatomic) BOOL SupportedDeductionIntegral;
@property (assign, nonatomic) BOOL isSellOut;
@end
