//
//  SNEmotionToolbar.m
//  weibo
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNEmotionToolbar.h"

#define SNEmotionToolbarButtonMaxCount 4
@interface SNEmotionToolbar()
/**  记录选中的button*/
@property (nonatomic, assign) UIButton *selectedButton;
@end
@implementation SNEmotionToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton:@"最近" tag:SNEmotionTypeRecent];
        [self setupButton:@"默认" tag:SNEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:SNEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:SNEmotionTypeLxh];
        
       
    }
    return self;
}

- (UIButton *)setupButton:(NSString *)title tag:(SNEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateSelected)];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [button addTarget:self action:@selector(buttOnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addSubview:button];
    
    int count = (int)self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizedWithName:@"compose_emotion_table_left_normal"] forState:(UIControlStateNormal)];
        [button setBackgroundImage:[UIImage resizedWithName:@"compose_emotion_table_left_selected"] forState:(UIControlStateSelected)];
    } else if (count == SNEmotionToolbarButtonMaxCount) {// 最后的按钮
        [button setBackgroundImage:[UIImage resizedWithName:@"compose_emotion_table_right_normal"] forState:(UIControlStateNormal)];
        [button setBackgroundImage:[UIImage resizedWithName:@"compose_emotion_table_right_selected"] forState:(UIControlStateSelected)];
    } else
    {
        [button setBackgroundImage:[UIImage resizedWithName:@"compose_emotion_table_mid_normal"] forState:(UIControlStateNormal)];
        [button setBackgroundImage:[UIImage resizedWithName:@"compose_emotion_table_mid_selected"] forState:(UIControlStateSelected)];
    }
    
    return button;
}


/** 工具条的按钮点击事件*/
- (void)buttOnClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:(int)button.tag];
    }
}

- (void)setDelegate:(id<SNEmotionToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    UIButton *defaultButton = (UIButton *)[self viewWithTag:SNEmotionTypeDefault];
    [self buttOnClick:defaultButton];
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    // 设置工具条按钮的frame®
    CGFloat buttonW = self.width / SNEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    
    // 设置工具条的按钮frame
    for (int i = 0; i < SNEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i *  buttonW;
    }
}
@end
