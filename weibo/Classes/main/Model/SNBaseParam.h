//
//  SNBaseParam.h
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNBaseParam : NSObject
/**
 *  access_token	string	用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;
@end
