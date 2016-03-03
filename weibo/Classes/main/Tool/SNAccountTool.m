//
//  SNAccountTool.m
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNAccountTool.h"
#import "SNAccount.h"

#define SNAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation SNAccountTool

// 读取账号
+ (SNAccount *)account
{
    SNAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SNAccountFilePath];
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] == NSOrderedDescending) {// 过期
        return nil;
    }
    return account;
}

+ (void)save:(SNAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:SNAccountFilePath];
    
}
@end
