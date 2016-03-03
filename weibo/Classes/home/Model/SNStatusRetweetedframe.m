//
//  SNRetweetedframe.m
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatusRetweetedframe.h"
#import "SNStatues.h"
#import "SNUser.h"
#import "SNStatusPhotosView.h"

@implementation SNStatusRetweetedframe
- (void)setRetweetedSatus:(SNStatues *)retweetedSatus
{
    _retweetedSatus = retweetedSatus;
    
    
    // 昵称
    CGFloat nameX = SNStatusCellInset;
    CGFloat nameY = SNStatusCellInset;
    CGSize nameSize = [[NSString stringWithFormat:@"@%@", retweetedSatus.user.name] sizeWithFont:SNStatusOriginalNameFont];
    self.nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + SNStatusCellInset;
    
    CGFloat maxWidth = SNScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    CGSize textSize = [retweetedSatus.text sizeWithFont:SNStatusOriginalTextFont constrainedToSize:maxSize];
    
    self.textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    
    CGFloat H = 0;
    if (retweetedSatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
        CGSize photosSize = [SNStatusPhotosView sizeWithPhotosCount:(int)retweetedSatus.pic_urls.count];
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
