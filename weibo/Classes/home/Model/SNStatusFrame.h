//
//  SNStatusFrame.h
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNStatues, SNStatusDetailframe;

@interface SNStatusFrame : NSObject
/** 子空间*/

@property (nonatomic, strong, readonly) SNStatusDetailframe *detailFrame;
@property (nonatomic, assign, readonly) CGRect toolbarFrame;
/** 微博数据模型*/
@property (nonatomic, strong) SNStatues *status;


@property (nonatomic, assign) CGFloat cellHeight;
@end
