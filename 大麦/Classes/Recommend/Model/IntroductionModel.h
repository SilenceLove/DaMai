//
//  IntroductionModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroductionOneModel.h"
@interface IntroductionModel : NSObject
@property (copy, nonatomic) NSString *IsAnswer;
@property (copy, nonatomic) NSString *OpenCountdown;
@property (strong, nonatomic) IntroductionOneModel *p;
@property (copy, nonatomic) NSArray *f;
@property (assign, nonatomic) BOOL CredentialsPolicyAvailable;
@property (copy, nonatomic) NSString *Timestamp;
@property (assign, nonatomic) BOOL F1;
@end
