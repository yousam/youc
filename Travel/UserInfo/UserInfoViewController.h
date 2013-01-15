//
//  UserInfoViewController.h
//  Travel
//
//  Created by home auto on 12-8-19.
//  Copyright (c) 2012年 st. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
#import "ASIFormDataRequest.h"
#import "System.h"
@class GCDiscreetNotificationView;

@interface UserInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>
{
    ASIFormDataRequest* request;
    NSMutableArray *dataList;
    
    //数量Label 游记，关注，粉丝，收藏，留言
    UILabel *lblTravelnum, *lblAttentionnum, *lblFansnum, *lblCollectsnum, *lblLeavesnum;
    //名字，签名
    UILabel *lblName, *lblSigname;
}

@property (retain, nonatomic) GCDiscreetNotificationView *notificationView;
@property (retain, nonatomic) ASIFormDataRequest* request;
@property (retain, nonatomic) IBOutlet UITableView *tabView;
@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (retain, nonatomic) IBOutlet UrlImageView *headImg;


- (IBAction)onClick:(id)sender;

@property (retain, nonatomic) IBOutlet UrlImageView *coverImg;


- (IBAction)onNav:(id)sender;

//初始化Button
-(void)initButton;
-(void)getData;

@end
