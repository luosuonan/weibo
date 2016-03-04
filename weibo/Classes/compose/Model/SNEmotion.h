//
//  SNEmotion.h
//  weibo
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;
/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;
@end
