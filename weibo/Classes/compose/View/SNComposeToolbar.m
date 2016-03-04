//
//  SNComposeToolbar.m
//  weibo
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNComposeToolbar.h"

@interface SNComposeToolbar()
@property (nonatomic, weak) UIButton *emotionButton;
@end
@implementation SNComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
//        self.backgroundColor = [UIColor whiteColor];
        // 添加所有的子控件
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:SNComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:SNComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:SNComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:SNComposeToolbarButtonTypeTrend];
        self.emotionButton = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:SNComposeToolbarButtonTypeEmotion];
    }
    return self;
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) {
        // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
    } else {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_mentionbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] forState:UIControlStateNormal];
    }
}


/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(SNComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}


- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:(int)button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}


@end
