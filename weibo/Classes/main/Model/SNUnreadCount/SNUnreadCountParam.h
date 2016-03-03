//
//  SNUnreadCountParam.h
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNBaseParam.h"

@interface SNUnreadCountParam : SNBaseParam
/**uid	false	int64	需要查询的用户ID。*/
@property (nonatomic, copy) NSString *uid;
@end
