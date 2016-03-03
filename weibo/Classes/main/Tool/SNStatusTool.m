//
//  SNStatusTool.m
//  weibo
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusTool.h"
#import "SNHttpTool.h"
#import "MJExtension.h"


@implementation SNStatusTool

+ (void)homeStatusWithParam:(SNHomeStatusParam *)param success:(void (^)(SNHomeStatusResult *))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = param.mj_keyValues;
    
    [SNHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id resposnseObj) {
        if (success) {
            SNHomeStatusResult *result = [SNHomeStatusResult mj_objectWithKeyValues:resposnseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)sendStatusWithParam:(SNSendStatusParam *)param success:(void (^)(SNSendStatusResult *))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = param.mj_keyValues;
    
    [SNHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id resposnseObj) {
        if (success) {
            SNSendStatusResult *result = [SNSendStatusResult mj_objectWithKeyValues:resposnseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
