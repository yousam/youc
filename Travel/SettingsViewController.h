//
//  SettingsViewController.h
//  Travel
//
//  Created by 王俊 on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *tableTitles;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tabSetting;

- (void)setVisible:(BOOL)visible;

@end
