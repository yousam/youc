//
//  PrivateLetterViewController.h
//  Travel
//
//  Created by 王俊 on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "System.h"
@class GCDiscreetNotificationView;
@interface PrivateLetterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    ASIHTTPRequest* request;
    NSMutableArray*dataList;
}
@property (nonatomic, retain) GCDiscreetNotificationView *notificationView;
@property (retain, nonatomic) IBOutlet UITableView *tab;
@property(retain,nonatomic)ASIHTTPRequest* request;
-(void)getData;
-(IBAction)onNav:(id)sender ;


@end