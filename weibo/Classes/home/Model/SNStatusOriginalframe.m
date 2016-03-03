//
//  SNOriginalframe.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusOriginalframe.h"
#import "SNStatues.h"
#import "SNUser.h"
#import "SNStatusPhotosView.h"

@implementation SNStatusOriginalframe
- (void)setStatus:(SNStatues *)status
{
    _status = status;
    
    // 头像
    CGFloat iconX = SNStatusCellInset;
    CGFloat iconY = SNStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + SNStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:SNStatusOriginalNameFont];
    self.nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    if (status.user.isVip) {
        // vip
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + SNStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    
    
    
    // 正文
    CGFloat textX = iconX;
    CGFloat iconMaxY = CGRectGetMaxY(self.iconFrame);
    CGFloat textY = iconMaxY + SNStatusCellInset;
    
    CGFloat maxWidth = SNScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:SNStatusOriginalTextFont constrainedToSize:maxSize];
    
    self.textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    CGFloat H = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
        CGSize photosSize = [SNStatusPhotosView sizeWithPhotosCount:(int)status.pic_urls.count];
        self.photosFrame = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        H = CGRectGetMaxY(self.photosFrame) + SNStatusCellInset;
    } else
    {
        H = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
    }
    
    // 自己的frame
    self.frame = CGRectMake(0, 0, SNScreenWidth, H);

    

}
@end
