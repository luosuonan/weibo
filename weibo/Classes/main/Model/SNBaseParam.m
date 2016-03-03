//
//  SNBaseParam.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNBaseParam.h"
#import "SNAccount.h"
#import "SNAccountTool.h"

@implementation SNBaseParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.access_token = [SNAccountTool account].access_token;
    }
    return self;
}
+ (instancetype)param
{
    return [[self alloc] init];
}
@end
