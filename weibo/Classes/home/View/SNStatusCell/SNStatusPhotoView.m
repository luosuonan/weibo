
//
//  SNStatusPhotoView.m
//  weibo
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusPhotoView.h"
#import "SNPhoto.h"
#import "UIImageView+WebCache.h"

@interface SNStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;

@end
@implementation SNStatusPhotoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}
- (void)setPhoto:(SNPhoto *)photo
{
    _photo = photo;
   
    
    // 1.下载图片
    
//    SNLog(@"%@", photo.thumbnail_pic);
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];

    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gifView.hidden = NO;
    } else
    {
        self.gifView.hidden = YES;
    }

}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
