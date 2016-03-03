//
//  SNStatusTool.h
//  weibo
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//  微博业务类，处理微博一切业务

#import <Foundation/Foundation.h>
#import "SNHomeStatusParam.h"
#import "SNHomeStatusResult.h"
#import "SNSendStatusParam.h"
#import "SNSendStatusResult.h"

@interface SNStatusTool : NSObject

+ (void)homeStatusWithParam:(SNHomeStatusParam *)param success:(void (^)(SNHomeStatusResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)sendStatusWithParam:(SNSendStatusParam *)param success:(void (^)(SNSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
