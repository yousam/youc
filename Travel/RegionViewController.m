//
//  RegionViewController.m
//  Travel
//
//  Created by 王俊 on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegionViewController.h"
#import "SearchViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "SearchTravelCell.h"
#import "GCDiscreetNotificationView.h"
#import "NSString+URLEncoding.h"
#import "JSONKit.h"
#import "HeadIntegrate.h"
#import "HomeViewController.h"
#import "System.h"

@implementation RegionViewController
@synthesize tab;
@synthesize request,notificationView;

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden=YES;
    regionListData = [[NSMutableArray alloc] init];
    scenicsListData = [[NSMutableArray alloc] init];
    state=0;
    [super viewDidLoad];

    [self getData];
}

- (void)viewDidUnload {
    [self setTab:nil];
    [super viewDidUnload];
}

- (void)dealloc {
    [regionListData release];
    [scenicsListData release];
    [tab release];
    [super dealloc];
}

#pragma mark - Public

- (void)setVisible:(BOOL)visible {
    self.view.hidden = !visible;
}

- (IBAction)onClick:(id)sender {
    if ([sender tag]==1) {
        state=0;
        
        if([regionListData count] > 0){
            [tab reloadData];
            return;
        }
    }
    else{
        state=1;
        
        if([scenicsListData count] > 0){
            [tab reloadData];
            return;
        }
    }
    
    [self getData];
}

#pragma mark - 数据
-(void)getData{
    //region?lgt=35&lat=115  regionListData
    //scenics?lgt=35&lat=115 scenicsListData
    if (![System connectedToNetwork])
	{
		return;
	}
    
    NSString * strUrl;
    
    if (state == 0) {
        strUrl = [NSString stringWithFormat:@"%@region?lgt=35&lat=115", API_SEAECHSERVER_ADR];
    }
    else{
        strUrl = [NSString stringWithFormat:@"%@scenics?lgt=35&lat=115&range=150", API_SEAECHSERVER_ADR];
    }
    
	NSURL * url=[NSURL URLWithString:strUrl];
	self.request=[ASIFormDataRequest requestWithURL:url];
	self.request.delegate=self;
	[request setRequestMethod:@"GET"];
    [ASIFormDataRequest setShouldUpdateNetworkActivityIndicator:NO];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)aRequest
{
    NSString *responseString =[[NSString alloc] initWithData:[aRequest responseData] encoding:NSUTF8StringEncoding];
    
    NSDictionary*values=[responseString objectFromJSONString];//json字符串 序列化成对象 新方法
    if (values) {
        //NSDictionary *body= [values objectForKey:@"body"];
        
        if (state == 0) {
            [regionListData removeAllObjects];
            [regionListData addObjectsFromArray:[values objectForKey:@"body"]];
        }
        else{
            NSDictionary *body= [values objectForKey:@"body"];
            [scenicsListData removeAllObjects];
            [scenicsListData addObject:[body objectForKey:@"nearScenicses"]];
            [scenicsListData addObject:[body objectForKey:@"recommendScenicses"]];
        }
        
        [tab reloadData];
    }
    [self.notificationView hide:YES];
    
    [responseString release];
}

- (void)requestFailed:(ASIHTTPRequest *)aRequest
{
    [self.notificationView hide:YES];
}


- (void)requestStarted:(ASIHTTPRequest *)aRequest
{
    [self.notificationView show:YES];
}
- (void)requestRedirected:(ASIHTTPRequest *)request{
    
    
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (state==1) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (state==1) {
        return [[scenicsListData objectAtIndex:section] count];
    }
    else {
        return regionListData.count+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (state==0) {
        return 40;
    }
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (state==0) return nil;
    
    UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30.0)] autorelease];
    
    UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 30.0);
    
    if (section == 0) {
        headerLabel.text =  @" 推荐景点";
    }else{
        headerLabel.text = @" 附近的目的地";
    }
    [customView addSubview:headerLabel];
    return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (state==0) return 0;
    return 30.0;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // ...
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //新增测试代码 右边改变中间界面内容
    DDMenuController *menuController = (DDMenuController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    HomeViewController *user=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:user];
    
    [menuController setRootController:navController animated:YES];     
    [user release];
}

#pragma mark - UITableView datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (state==0) {
        static NSString *CellIdentifier = @"RegionViewTableCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        int index = indexPath.row-1;
        if (index < 0) {
            cell.textLabel.text = @"         周围";
        }
        else if ([regionListData count]>index) {
            cell.textLabel.text = [NSString stringWithFormat:@"         %d %@",index, [[regionListData objectAtIndex:index] objectForKey:@"county"]];
        }
        
        return cell;
    }
    else{
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchTravelCell" owner:self options:nil];
        SearchTravelCell*cell=nil;
        for (id obj in nib) {
            if ([obj isKindOfClass:[SearchTravelCell class]]) {
                cell = (SearchTravelCell *) obj;
            }
        }
        
        cell.lblTitle.text = [[[scenicsListData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.lblNear.text = [[[scenicsListData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"address"];
        cell.lblMove.text = [NSString stringWithFormat:@"%@在附近出没", [[[scenicsListData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"visitCount"]];
        
        
        return cell;
    }
}


@end
