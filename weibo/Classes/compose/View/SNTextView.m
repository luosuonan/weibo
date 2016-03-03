//
//  SNTextView.m
//  weibo
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNTextView.h"

@interface SNTextView()<UITextFieldDelegate>
@property (nonatomic ,weak) UILabel *placehoderLabel;

@end

@implementation SNTextView

#pragma mark - 代理方法


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 显示占位文字
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.backgroundColor = [UIColor clearColor];
        placehoderLabel.numberOfLines = 0;
        
        [self addSubview:placehoderLabel];
        _placehoderLabel = placehoderLabel;
        
        // 设置默认颜色
        self.placehoderLabel.textColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange
{
    self.placehoderLabel.hidden = (self.text.length != 0);
    
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placehoderLabel.font = font;
    // 重新布局
    [self setNeedsLayout];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
    
    // 重新布局
    [self setNeedsLayout];
    
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
    self.placehoderLabel.width = self.width - self.placehoderLabel.x * 2;
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLabel.font constrainedToSize:maxSize];
    self.placehoderLabel.height = placehoderSize.height;
}

@end
