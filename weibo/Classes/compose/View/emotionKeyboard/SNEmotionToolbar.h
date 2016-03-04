//
//  SNEmotionToolbar.h
//  weibo
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SNEmotionTypeRecent, // 最近
    SNEmotionTypeDefault, // 默认
    SNEmotionTypeEmoji, // Emoji
    SNEmotionTypeLxh // 浪小花
} SNEmotionType;
@class SNEmotionToolbar;
@protocol SNEmotionToolbarDelegate <NSObject>

- (void)emotionToolbar:(SNEmotionToolbar *)toolbar didSelectedButton:(SNEmotionType)emotionType;

@end
@interface SNEmotionToolbar : UIView
@property (nonatomic, weak) id<SNEmotionToolbarDelegate> delegate;
@end
