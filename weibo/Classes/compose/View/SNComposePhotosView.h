//
//  SNComposePhotoView.h
//  weibo
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNComposePhotosView : UIView


@property (nonatomic, strong) NSArray *images;
- (void)addImage:(UIImage *)image;

@end
