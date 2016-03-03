//
//  SNAccountTool.h
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNAccount;

@interface SNAccountTool : NSObject

+ (SNAccount *)account;
+ (void)save:(SNAccount *)account;

@end
