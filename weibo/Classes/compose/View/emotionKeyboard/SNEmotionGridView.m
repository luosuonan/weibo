//
//  SNEmotionGridView.m
//  weibo
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNEmotionGridView.h"
#import "SNEmotion.h"



@interface SNEmotionGridView()
@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray *emotionViews;
@end
@implementation SNEmotionGridView


- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:(UIControlStateNormal)];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:(UIControlStateHighlighted)];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = (int)emotions.count;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = [[UIButton alloc] init];
        emotionView.adjustsImageWhenHighlighted = NO;
        SNEmotion *emotion = emotions[i];
        if (emotion.code) { // emoji表情
            // emotion.code == 0x1f603 --> \u54367
            // emoji的大小取决于字体大小
            emotionView.titleLabel.font = [UIFont systemFontOfSize:32];
            [emotionView setTitle:emotion.emoji forState:UIControlStateNormal];
        } else { // 图片表情
            NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
            [emotionView setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
        }
        [self addSubview:emotionView];
        [self.emotionViews addObject:emotionView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    int count = (int)self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / HMEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / HMEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % HMEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / HMEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}
@end
