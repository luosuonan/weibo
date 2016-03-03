//
//  SNTitleButton.m
//  weibo
//
//  Created by admin on 16/2/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNTitleButton.h"

@implementation SNTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.titleLabel.font = SNNavgationFont;
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        // 高亮的时候不需要调整图片 
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
// 设置内部图标的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}
// 设置文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - self.height;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    //  计算文字大小
    CGSize titleSzie = [title sizeWithFont:self.titleLabel.font];
    self.width = titleSzie.width + self.height + 10;
}

@end
