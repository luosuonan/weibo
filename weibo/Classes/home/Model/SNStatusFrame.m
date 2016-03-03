//
//  SNStatusFrame.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusFrame.h"
#import "SNStatues.h"
#import "SNStatusDetailframe.h"

@implementation SNStatusFrame
- (void)setStatus:(SNStatues *)status
{
    _status = status;
    

    // 3.计算微博具体内容
    [self setupDetailFrame];
    // 4.计算底部工具条
    [self setupToolbarFrame];
    // 5.计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}



/** 3.计算微博具体内容*/

- (void)setupDetailFrame
{
     SNStatusDetailframe *detailFrame = [[SNStatusDetailframe alloc] init];
    detailFrame.status = self.status;
    _detailFrame = detailFrame;
}
/** 4.计算底部工具条*/

- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = SNScreenWidth;
    CGFloat toolbarH = 35;
    _toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}


@end
