//
//  SNLoadMoreFooter.m
//  weibo
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNLoadMoreFooter.h"
#import "Masonry.h"


@interface SNLoadMoreFooter()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;


@end
@implementation SNLoadMoreFooter

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.width = SNScreenWidth;
    self.statusLabel.width = SNScreenWidth;
    self.loadingView.y = SNScreenWidth - self.loadingView.width;
}
+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SNLoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
    
}

@end
