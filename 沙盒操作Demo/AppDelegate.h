//
//  AppDelegate.h
//  沙盒操作Demo
//
//  Created by zk on 16/1/4.
//  Copyright © 2016年 zhu. All rights reserved.
//
 #define SCRRENWIDTH   [[UIScreen mainScreen]bounds].size.width
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)NSArray *app_imageArray;
@property (nonatomic,strong)NSArray *app_videoArray;
@end

