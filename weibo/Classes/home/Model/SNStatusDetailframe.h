//
//  SNStatusDetailframe.h
//  weibo
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNStatues;

@class SNStatusOriginalframe, SNStatusRetweetedframe;
@interface SNStatusDetailframe : NSObject
@property (nonatomic, strong, readonly) SNStatusOriginalframe *originalFrame;
@property (nonatomic, strong, readonly) SNStatusRetweetedframe *retweetedFrame;
@property (nonatomic, assign) CGRect frame;
/** 微博数据模型*/
@property (nonatomic, strong) SNStatues *status;
@end
