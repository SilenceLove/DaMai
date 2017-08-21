//
//  HttpTool.h
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (void)getUrlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
