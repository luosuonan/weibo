//
//  SNEmotionListView.m
//  weibo
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNEmotionListView.h"
#import "SNEmotionGridView.h"

// 表情的最大行数
#define SNEmotionMaxRows 3
// 表情的最大列数
#define SNEmotionMaxCols 7
// 每页最多显示多少个表情
#define SNEmotionMaxCountPerPage (SNEmotionMaxRows * SNEmotionMaxCols - 1)

@interface SNEmotionListView()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIPageControl *pageControl;
@end
@implementation SNEmotionListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
//        scrollView.backgroundColor = [UIColor redColor];
        
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    SNLog(@"%ld", emotions.count);
    // 设置总页数
    self.pageControl.numberOfPages = (emotions.count + SNEmotionMaxCountPerPage - 1) / SNEmotionMaxCountPerPage;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        
        
        
        SNEmotionGridView *gridView = [[SNEmotionGridView alloc] init];
        int loc = i * SNEmotionMaxCountPerPage;
        int len = SNEmotionMaxCountPerPage;
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = (int)emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        [self.scrollView addSubview:gridView];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // pageControl 的 frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // scrollView 的 frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 3.设置UIScrollView内部控件的尺寸
    int count = (int)self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        SNEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
