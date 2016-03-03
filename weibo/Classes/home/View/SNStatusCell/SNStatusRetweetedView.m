//
//  SNStatusRetweetedView.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusRetweetedView.h"
#import "SNStatusRetweetedframe.h"
#import "SNStatues.h"
#import "SNUser.h"
#import "SNStatusPhotosView.h"

@interface SNStatusRetweetedView()
/** 昵称*/
@property (nonatomic, weak) UILabel *nameLabel;
/** 文字内容*/
@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) SNStatusPhotosView *photosView;
@end
@implementation SNStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedWithName:@"timeline_retweet_background"];
        self.highlightedImage = [UIImage resizedWithName:@"timeline_retweet_background_highlighted"];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SNStatusRetweetedlNameFont;
        nameLabel.textColor = SNColor(74, 102, 105);
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = SNStatusRetweetedTextFont;
        textLabel.numberOfLines = 0; 
        [self addSubview:textLabel];
        self.textLabel = textLabel;
//        [self setNeedsDisplay];
        
        SNStatusPhotosView *photosView = [[SNStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;

    }
    return self;
}

- (void)setRetweetedFrame:(SNStatusRetweetedframe *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    self.frame = retweetedFrame.frame;
    SNStatues *status = retweetedFrame.retweetedSatus;
    SNUser *user = status.user;
    
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    
    self.textLabel.text = status.text;  
    self.textLabel.frame = retweetedFrame.textFrame;
    
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
    } else
    {
        self.photosView.hidden = YES;
    }
    
}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    [[UIImage resizedWithName:@"timeline_retweet_background"] drawInRect:rect];
//}


@end
