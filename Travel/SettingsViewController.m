//
//  SettingsViewController.m
//  Travel
//
//  Created by 王俊 on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserInfoViewController.h"
#import "UserManagerViewController.h"
#import "SearchViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "SetUpViewController.h"
#import "HomeViewController.h"
#import "OpinionViewController.h"
#import "PrivateLetterViewController.h"
#import "UserUtils.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
- (void)viewDidLoad {
     self.navigationController.navigationBarHidden=YES; 
    NSString *userName = @"请登录";
    
    if ([UserUtils getUserId] > 0) {
        userName = [UserUtils getUserName];
    } 
    tableTitles = [NSMutableArray arrayWithObjects:userName,@"主页",@"精选",@"设置",@"搜索",@"关于",@"意见反馈",@"私信",@"帮助",nil];
    [tableTitles retain];
    //注册通知 监听用户登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserInfo:) name:@"loadUserInfo" object:nil];
    [super viewDidLoad];  
    
}
//监听用户登录后改变个人主页列表项
-(void)loadUserInfo:(id)sender{

    id obj=[[sender object]objectForKey:@"userName"];
    if (obj) {
        [tableTitles replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@-个人主页",obj]];
        [self.tabSetting reloadData];
    }
}
- (void)viewDidUnload {
    [tableTitles release];
    [self setTabSetting:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     [super viewDidUnload];
}

- (void)dealloc {
    [tableTitles release];
    [_tabSetting release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - Public

- (void)setVisible:(BOOL)visible {
    self.view.hidden = !visible;
}

#pragma mark - UITableView delegate

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // ...新增代码 触发中间界面显示新内容。
    DDMenuController *menuController = (DDMenuController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *navController;
    
    if (indexPath.row==0) {
        if ([UserUtils getUserId] > 0) {
            UserInfoViewController *user=[[UserInfoViewController alloc]initWithNibName:@"UserInfoViewController" bundle:nil];
            navController = [[UINavigationController alloc] initWithRootViewController:user];
            [user release];
        }
        else{
            UserManagerViewController *user=[[UserManagerViewController alloc]initWithNibName:@"UserManagerViewController" bundle:nil];
            navController = [[UINavigationController alloc] initWithRootViewController:user];
            [user release];
        }
		
		[menuController setRootController:navController animated:YES];
    }
    if (indexPath.row==1) {
        HomeViewController*home=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:home];
		[home release];
		[menuController setRootController:navController animated:YES];
    }
    if (indexPath.row==3) {
        SetUpViewController*setUp=[[SetUpViewController alloc]initWithNibName:@"SetUpViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:setUp];
		[menuController setRootController:navController animated:YES];     
        [setUp release];
    }
    if (indexPath.row==4) {
        SearchViewController *user=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:user];
		
		[menuController setRootController:navController animated:YES];     
        [user release];
    }
    if (indexPath.row==6) {
        OpinionViewController*opinion=[[OpinionViewController alloc]initWithNibName:@"OpinionViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:opinion];
		
		[menuController setRootController:navController animated:YES];     
        [opinion release];
    }
    if (indexPath.row==7) {
        PrivateLetterViewController*pri=[[PrivateLetterViewController alloc]initWithNibName:@"PrivateLetterViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:pri];
		
		[menuController setRootController:navController animated:YES];     
        [pri release];
    }

}

#pragma mark - UITableView datasource

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"Ethan Gao";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SettingsViewTableCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    if ([tableTitles count]>indexPath.row) {
        cell.textLabel.text = [tableTitles objectAtIndex:indexPath.row];
    }
	return cell;
}

@end
