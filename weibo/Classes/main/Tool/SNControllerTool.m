//
//  SNControllerTool.m
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNControllerTool.h"
#import "SNTabBarController.h"
#import "SNNewFeatureViewController.h"

@implementation SNControllerTool
+ (void)chooseRootViewController
{
    
    
    SNTabBarController *tabbarVc = [[SNTabBarController alloc] init];
    SNNewFeatureViewController *newFeature = [[SNNewFeatureViewController alloc] init];
    // 从沙盒中取出上次记录的版本号
    // 需要桥接
    NSString *versionKey = (__bridge NSString*)kCFBundleVersionKey;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![currentVersion isEqualToString:lastVersion]) {
        
        window.rootViewController = newFeature;
        [defaults setValue:currentVersion forKey:versionKey];
        [defaults synchronize];
        
        window.rootViewController = tabbarVc;
    } else {
        window.rootViewController = tabbarVc;
    }
}
@end
