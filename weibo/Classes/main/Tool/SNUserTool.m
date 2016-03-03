//
//  SNUserTool.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNUserTool.h"
#import "MJExtension.h"
#import "SNHttpTool.h"
#import "SNBaseTool.h"
@implementation SNUserTool
+ (void)UserInfoWithParam:(SNUserInfoParam *)param success:(void (^)(SNUserInfoResult *result))success failure:(void (^)(NSError *error))failure
{
    
    [SNBaseTool getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[SNUserInfoResult class] success:success failure:failure];
}

+ (void)unreadCountWithParam:(SNUserInfoParam *)param success:(void (^)(SNUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [SNBaseTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[SNUnreadCountResult class] success:success failure:failure]; 
}

@end
