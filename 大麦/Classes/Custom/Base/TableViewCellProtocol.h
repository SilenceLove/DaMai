//
//  TableViewCellProtocol.h
//  他趣
//
//  Created by 洪欣 on 16/12/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellProtocol <NSObject>
- (void)setupViews;
- (void)bindViewModel;
@end
