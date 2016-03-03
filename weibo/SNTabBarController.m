//
//  SNTabBarController.m
//  weibo
//
//  Created by admin on 16/2/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNTabBarController.h"
#import "SNHomeViewController.h"
#import "SNMessageViewController.h"
#import "SNDiscoverViewController.h"
#import "SNProfileViewController.h"
#import "SNNavigationController.h"
#import "SNTabBar.h"
#import "SNComposeViewController.h"
#import "SNUserTool.h"
#import "SNUserInfoParam.h"
#import "SNAccountTool.h"
#import "SNAccount.h"

@interface SNTabBarController ()<UITabBarControllerDelegate, SNTabBarDelegate>
@property (nonatomic, strong) SNHomeViewController *home;
@property (nonatomic, strong) SNProfileViewController *me;
@property (nonatomic, strong) SNMessageViewController *message;
@property (nonatomic, weak) UIViewController *lastSelectedViewController;

@end

@implementation SNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addAllChildVcs];
    
    // 调整tabbar
    SNTabBar *customTabBar = [[SNTabBar alloc] init];
    
//    customTabBar.backgroundImage = [UIImage imageWithName:@"tabbar_background"];
//    customTabBar.selectionIndicatorImage = [UIImage imageWithName:@"navigationbar_button_background"];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.delegate = self;
}

- (void)getUnreadCount
{
    SNUserInfoParam *param = [[SNUserInfoParam alloc] init];
    param.access_token = [SNAccountTool account].access_token;
    param.uid = [SNAccountTool account].uid;
    
    [SNUserTool unreadCountWithParam:param success:^(SNUnreadCountResult *result) {
//        SNLog(@"%d",  result.messageCount);
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else
        {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else
        {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        if (result.follower == 0) {
            self.me.tabBarItem.badgeValue = nil;
        } else
        {
            self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)tabBarDidClickPlusButton:(SNTabBar *)tabBar
{
    SNComposeViewController *composeVc = [[SNComposeViewController alloc] init];
    
    SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)addAllChildVcs
{
    // 添加子控制器
    SNHomeViewController *home = [[SNHomeViewController alloc] init];
    [self addOneChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    self.home = home;
//    self.lastSelectedViewController = home;
    
    SNMessageViewController *message = [[SNMessageViewController alloc] init];
    [self addOneChildVc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    self.message = message;
    
    SNDiscoverViewController *discover = [[SNDiscoverViewController alloc] init];
    [self addOneChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    SNProfileViewController *me = [[SNProfileViewController alloc] init];
    [self addOneChildVc:me title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    self.me = me;
}

// 添加子控制器
- (void)addOneChildVc:(UIViewController *)childVc
                title:(NSString *)title
                image:(NSString *)imageName
        selectedImage:(NSString *)selectedImageName
{
    
//    childVc.tabBarItem.title = title;
//    childVc.navigationItem.title = title;
    // 相当于同时设置上面两个标题
    childVc.title = title;
//    childVc.view.backgroundColor = [UIColor whiteColor];
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:(UIControlStateNormal)];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    selectedTextAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:(UIControlStateSelected)];
    
    
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    // iOS7后不需要再判断，都是扁平化的了
    //    $(SRCROOT)/weibo/Prefix.pch 添加prefix header的环境变量
    if (iOS7) {
        selectedImage = [selectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        childVc.tabBarItem.selectedImage = selectedImage;
    } else
    {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    SNNavigationController *nav = (SNNavigationController *)viewController;
//    UIViewController *vc = [nav.viewControllers firstObject];
//    SNLog(@"%@", vc);
//    if ([vc isKindOfClass:[SNHomeViewController class]]) {
//        if (self.lastSelectedViewController == vc) {
//            [self.home refresh:YES];
//        } else {
//            [self.home refresh:NO];
//        }
//
//    }
//    self.lastSelectedViewController = vc;

    
}


@end
