//
//  SNHttpTool.h
//  weibo
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//  网路请求工具类

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SNHttpTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id resposnseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id resposnseObj))success failure:(void(^)(NSError *error))failure;

@end
