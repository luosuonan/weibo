//
//  SNStatusOriginalView.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusOriginalView.h"
#import "SNStatusOriginalframe.h"
#import "SNStatues.h"
#import "SNUser.h"
#import "SDImageCache.h"
#import "SNStatusPhotosView.h"

@interface SNStatusOriginalView()
/** 昵称*/
@property (nonatomic, weak) UILabel *nameLabel;
/** 文字内容*/
@property (nonatomic, weak) UILabel *textLabel;
/** 时间*/
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源*/
@property (nonatomic, weak) UILabel *sourceLabel;
/** 图片*/
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标*/
@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) SNStatusPhotosView *photosView;
@end

@implementation SNStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SNStatusOriginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = SNStatusOriginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = SNStatusOriginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = SNStatusOriginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        
        
        SNStatusPhotosView *photosView = [[SNStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}


- (void)setOriginalFrame:(SNStatusOriginalframe *)originalFrame
{
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    SNStatues *status = originalFrame.status;
    SNUser *user = status.user;
    
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    self.nameLabel.text = status.user.name;
    
    self.textLabel.frame = originalFrame.textFrame;
    self.textLabel.backgroundColor = [UIColor greenColor];
    self.textLabel.text = status.text;
    
    NSString *time = status.created_at;
    
#warning 一直计算时间大小
    // 时间
    self.timeLabel.text = time;
    CGFloat timeX = CGRectGetMinX(originalFrame.nameFrame);
    CGFloat timeY = CGRectGetMaxY(originalFrame.nameFrame) + SNStatusCellInset;
    CGSize timeSize = [status.created_at sizeWithFont:SNStatusOriginalTimeFont];
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLabel.textColor = [UIColor orangeColor];
    
    // 来源
    self.sourceLabel.backgroundColor = [UIColor lightGrayColor];
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + SNStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SNStatusOriginalSourceFont];
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
   
    
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:nil];
    
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
    } else
    {
        self.photosView.hidden = YES;
    }
    
}



@end
