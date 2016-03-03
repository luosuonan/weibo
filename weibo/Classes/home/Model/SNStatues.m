//
//  SNStatues.m
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNStatues.h"
#import "SNPhoto.h"
#import "NSDate+MJ.h"

@implementation SNStatues
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [SNPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date = [fmt dateFromString:_created_at];
    
    if (date.isThisYear) {
        if (date.isToday) {
            NSDateComponents *components = [date deltaWithNow];
            if (components.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", components.hour];
            } else if (components.minute >= 1)
            {
                return [NSString stringWithFormat:@"%ld分钟前", components.minute];
            } else {
                return @"刚刚";
            }
        } else if (date.isYesterday)
        {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date];
        } else
        {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:date];
    }
}

//- (NSString *)source
//{
//    NSRange range;
//    range.location = [_source rangeOfString:@">"].location + 1;
//    range.length = [_source rangeOfString:@"</"].location - range.location;
//    NSString *subsource = [_source substringWithRange:range];
//    
//    return [NSString stringWithFormat:@"来自:%@", subsource];
//}

- (void)setSource:(NSString *)source
{
    _source = source;
    NSRange range;
    range.location = [_source rangeOfString:@">"].location + 1;
    range.length = [_source rangeOfString:@"</"].location - range.location;
    NSString *subsource = [_source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自:%@", subsource];
    
}

@end
