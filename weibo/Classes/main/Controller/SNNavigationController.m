//
//  SNNavigationController.m
//  weibo
//
//  Created by admin on 16/2/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNNavigationController.h"

@interface SNNavigationController ()

@end

@implementation SNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 第一次使用的时候调用一次
+ (void)initialize
{
    // 整个项目都会改变颜色，只需要设置一次,设置uibarbutton的主题
    // 设置普通状态
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttrs forState:(UIControlStateNormal)];
    // 设置高亮状态
    NSMutableDictionary *hightextAttrs = [NSMutableDictionary dictionary];
    hightextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [appearance setTitleTextAttributes:hightextAttrs forState:(UIControlStateHighlighted)];
    
    // 设置disabled状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:(UIControlStateDisabled)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(backHome)];
    }
    [super pushViewController:viewController animated:YES];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)backHome
{
    [self popToRootViewControllerAnimated:YES];
}
@end
