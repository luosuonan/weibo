//
//  SNUnreadCountResult.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNUnreadCountResult.h"

@implementation SNUnreadCountResult
- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}


- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}
@end
