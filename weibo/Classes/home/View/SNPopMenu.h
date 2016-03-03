//
//  SNPosition.h
//  weibo
//
//  Created by admin on 16/2/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SNPopMenuArrowPositionCenter = 0,
    SNPopMenuArrowPositionLeft,
    SNPopMenuArrowPositionRight
    
} SNPopMenuArrowPosition;
@class SNPopMenu;
@protocol SNPopMenuDelegate <NSObject>

- (void)popMenuDidDismissed:(SNPopMenu *)popMenu;

@end




@interface SNPopMenu : UIView
@property (nonatomic, weak) id<SNPopMenuDelegate> delegate;

@property (nonatomic, assign ,getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) SNPopMenuArrowPosition arrowPosition;


/**
 * 初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 * 设置菜单的悲剧图片
 */
- (void)setBackground:(UIImage *)background;

/**
 * 显示菜单
 */
- (void)showInRect:(CGRect)rect;


/**
 * 关闭菜单
 */
- (void)dismiss;

@end
