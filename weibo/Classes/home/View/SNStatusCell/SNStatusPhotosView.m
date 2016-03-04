//
//  SNStatusPhotosView.m
//  weibo
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusPhotosView.h"
#import "SNStatusPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SNPhoto.h"

#define SNStatusPhotosMaxCount 9
#define SNStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define SNStatusPhotoW 70
#define SNStatusPhotoH SNStatusPhotoW
#define SNStatusPhotoMargin 10

@implementation SNStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        // 预先创建9个图片控件
        for (int i = 0; i<SNStatusPhotosMaxCount; i++) {
            SNStatusPhotoView *photoView = [[SNStatusPhotoView alloc] init];
            photoView.tag = i;
            
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
            
            [self addSubview:photoView];
        }
    }
    return self;
}


- (void)tapPhoto:(UITapGestureRecognizer *)reginazer
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    NSMutableArray *photos = [NSMutableArray array];
    
    int count = (int)self.pic_urls.count;
    for (int i = 0; i < count; i++) {
        SNPhoto *pic = self.pic_urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    browser.currentPhotoIndex = reginazer.view.tag;
    [browser show];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.pic_urls.count;
    int maxCols = SNStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        SNStatusPhotoView *photoView = self.subviews[i];
        photoView.width = SNStatusPhotoW;
        photoView.height = SNStatusPhotoH;
        photoView.x = (i % maxCols) * (SNStatusPhotoW + SNStatusPhotoMargin);
        photoView.y = (i / maxCols) * (SNStatusPhotoH + SNStatusPhotoMargin);
    }
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    for (int i = 0; i<SNStatusPhotosMaxCount; i++) {
        SNStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}


+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int maxCols = SNStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * 70 + (totalCols - 1) * SNStatusPhotoMargin;
    CGFloat photosH = totalRows * 70 + (totalRows - 1) * SNStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
