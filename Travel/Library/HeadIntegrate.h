//
//  HeadIntegrate.h
//  Autohome
//
//  Created by 王俊 on 12-3-27.
//  Copyright 2012年 autohome. All rights reserved.
//
#import <Foundation/Foundation.h>
//自定义颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//系统默认的导航按钮
#define BARBUTTON(TITLE, SELECTOR)[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]
#define API_SEAECHSERVER_ADR (@"http://yun.youcn.com.cn/")          //线上地址
//#define API_SEAECHSERVER_ADR (@"http://localhost:8080/yun/")      //本地测试地址
#define NETWORK_BAD (@"您的网络好像有点问题，请重试")

@interface HeadIntegrate : NSObject

@end
