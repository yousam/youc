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

@interface PrivateLetterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    ASIFormDataRequest* request;
    NSMutableArray*dataList;
}

@property (retain, nonatomic) IBOutlet UITableView *tab;
-(void)getData;
-(IBAction)onNav:(id)sender ;


@end