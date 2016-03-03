//
//  SNTabBar.h
//  weibo
//
//  Created by admin on 16/2/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNTabBar;
@protocol SNTabBarDelegate <NSObject>

- (void)tabBarDidClickPlusButton:(SNTabBar *)tabBar;

@end

@interface SNTabBar : UITabBar

@property (nonatomic, weak) id<SNTabBarDelegate> delegate;

@end
