//
//  SNAccount.h
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNAccount : NSObject<NSCoding>
/**
 *  access_token	string	用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  expires_in	string	access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  uid	string	当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;

/**过期时间*/
@property (nonatomic, strong) NSDate *expires_time;

/** 用户的昵称*/
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDic:(NSDictionary *)dictionary;

@end
