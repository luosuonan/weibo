//
//  SNUserTool.h
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUserInfoParam.h"
#import "SNUserInfoResult.h"
#import "SNUnreadCountParam.h"
#import "SNUnreadCountResult.h"


@interface SNUserTool : NSObject
+ (void)UserInfoWithParam:(SNUserInfoParam *)param success:(void (^)(SNUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)unreadCountWithParam:(SNUserInfoParam *)param success:(void (^)(SNUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
