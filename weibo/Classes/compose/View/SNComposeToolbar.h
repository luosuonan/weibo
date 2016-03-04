//
//  SNComposeToolbar.h
//  weibo
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    SNComposeToolbarButtonTypeCamera, // 照相机
    SNComposeToolbarButtonTypePicture, // 相册
    SNComposeToolbarButtonTypeMention, // 提到@
    SNComposeToolbarButtonTypeTrend, // 话题
    SNComposeToolbarButtonTypeEmotion // 表情
} SNComposeToolbarButtonType;

@class SNComposeToolbar;
@protocol SNComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(SNComposeToolbar *)toolbar didClickedButton:(SNComposeToolbarButtonType)buttonType;

@end
@interface SNComposeToolbar : UIView
@property (nonatomic, weak) id<SNComposeToolbarDelegate> delegate;


// 是否显示表情按钮
@property (nonatomic, assign) BOOL showEmotionButton;
@end
