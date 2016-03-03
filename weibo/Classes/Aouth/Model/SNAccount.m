//
//  SNAccount.m
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNAccount.h"

@implementation SNAccount

+ (instancetype)accountWithDic:(NSDictionary *)dictionary
{
    SNAccount *account = [[SNAccount alloc] init];
    account.access_token = dictionary[@"access_token"];
    account.expires_in = dictionary[@"expires_in"];
    account.uid = dictionary[@"uid"];
    account.name = dictionary[@"name"];
    
    // 过期时间
    account.expires_time = [[NSDate date] dateByAddingTimeInterval:[account.expires_in doubleValue]];
    return account;
}

// 当文件解析出一个对象的时候调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

// 讲对象写入文件的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    
    [aCoder encodeObject:self.uid forKey:@"uid"];
}
@end
