//
//  NSUser.m
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNUser.h"

@implementation SNUser

- (BOOL)isVip{
    return self.mbtype > 2;
}

@end
