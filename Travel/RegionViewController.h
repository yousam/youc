//
//  RegionViewController.h
//  Travel
//
//  Created by 王俊 on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@class GCDiscreetNotificationView;

@interface RegionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>
{
    ASIFormDataRequest* request;
    NSMutableArray *regionListData;     //周围城市列表
    NSMutableArray *scenicsListData;    //周围景点(推荐)列表
    NSInteger state;
}

@property (retain, nonatomic) IBOutlet UITableView *tab;
@property (nonatomic, retain) GCDiscreetNotificationView *notificationView;
@property(retain,nonatomic)ASIFormDataRequest* request;

- (void)setVisible:(BOOL)visible;
- (IBAction)onClick:(id)sender;

@end
