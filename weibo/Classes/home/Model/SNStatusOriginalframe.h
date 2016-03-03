//
//  SNOriginalframe.h
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNStatues;

@interface SNStatusOriginalframe : NSObject
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect textFrame;
//@property (nonatomic, assign) CGRect sourceFrame;
//@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect vipFrame;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect photosFrame;


@property (nonatomic, strong) SNStatues *status;
@end
