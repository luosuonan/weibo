//
//  SNUnreadCountResult.h
//  weibo
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNUnreadCountResult : NSObject
/**status	int	新微博未读数*/

@property (nonatomic, assign) int status;
/**follower	int	新粉丝数*/
@property (nonatomic, assign) int follower;
/**cmt	int	新评论数*/
@property (nonatomic, assign) int cmt;
/**dm	int	新私信数*/
@property (nonatomic, assign) int dm;
/**mention_status	int	新提及我的微博数*/
@property (nonatomic, assign) int mention_status;
/**mention_cmt	int	新提及我的评论数*/
@property (nonatomic, assign) int mention_cmt;
/**group	int	微群消息未读数*/
@property (nonatomic, assign) int group;
/**private_group	int	私有微群消息未读数*/
@property (nonatomic, assign) int private_group;
/**notice	int	新通知未读数*/
@property (nonatomic, assign) int notice;
/**invite	int	新邀请未读数*/
@property (nonatomic, assign) int invite;
/**badge	int	新勋章数*/
@property (nonatomic, assign) int badge;
/**photo	int	相册消息未读数*/
@property (nonatomic, assign) int photo;
//msgbox	int	{{{3}}}

- (int)messageCount;

- (int)totalCount;
@end
