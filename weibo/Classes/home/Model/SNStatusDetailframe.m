//
//  SNStatusDetailframe.m
//  weibo
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusDetailframe.h"
#import "SNStatusRetweetedframe.h"
#import "SNStatusOriginalframe.h"
#import "SNStatues.h"

@implementation SNStatusDetailframe


- (void)setStatus:(SNStatues *)status
{
    _status = status;
    // 计算原创微博
    SNStatusOriginalframe *originFrame = [[SNStatusOriginalframe alloc] init];
    originFrame.status = status;
    _originalFrame = originFrame;
    // 计算转发微博
    
    CGFloat h = 0;
    if (status.retweeted_status) {
        
        SNStatusRetweetedframe *retweetedFrame = [[SNStatusRetweetedframe alloc] init];
        retweetedFrame.retweetedSatus = status.retweeted_status;
        
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originFrame.frame);
        retweetedFrame.frame = f;
        
        _retweetedFrame = retweetedFrame;
        h = CGRectGetMaxY(retweetedFrame.frame);
    }else
    {
        h = CGRectGetMaxY(originFrame.frame);
        
    }
    self.frame = CGRectMake(0, SNStatusCellMargin, SNScreenWidth, h);
    
}


@end
