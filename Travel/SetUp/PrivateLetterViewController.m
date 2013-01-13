//
//  PrivateLetterViewController.m
//  Travel
//
//  Created by 王颖 on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrivateLetterViewController.h"
#import "AppDelegate.h"
#import "PrivteCell.h"
//#import "JSON.h"
#import "HeadIntegrate.h"
#import "GCDiscreetNotificationView.h"
#import "NSString+URLEncoding.h"
#import "JSONKit.h"
@implementation PrivateLetterViewController
@synthesize tab;
@synthesize request,notificationView;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //先测试
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;

//    //暂时注释cell
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrivteCell" owner:self options:nil];
//    PrivteCell*cell=nil;
//    for (id obj in nib) {
//        if ([obj isKindOfClass:[PrivteCell class]]) {
//            cell = (PrivteCell *) obj;
//            
//        }
//    }
//    return cell;
    
}

#pragma mark - 数据
-(void)getData{
    if (![System connectedToNetwork])
	{
		return;
	}
    [dataList removeAllObjects];
    NSString * strUrl=
    [NSString stringWithFormat:@"%@city",
     API_SEAECHSERVER_ADR];
	NSURL * url=[NSURL URLWithString:strUrl];
	self.request=[ASIFormDataRequest requestWithURL:url];
	self.request.delegate=self;
	[request setRequestMethod:@"GET"];
    request.responseEncoding=NSUTF8StringEncoding;
    request.defaultResponseEncoding=NSUTF8StringEncoding;
    [ASIFormDataRequest setShouldUpdateNetworkActivityIndicator:NO];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)aRequest
{
    NSString *responseString =[aRequest.responseString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary*values=[responseString objectFromJSONString];//json字符串 序列化成对象 新方法
    if (values) {
        NSDictionary *body= [values objectForKey:@"body"];
        [dataList removeAllObjects];
        [dataList addObjectsFromArray:[body objectForKey:@"cityList"]];
        [tab reloadData];
    }
    [self.notificationView hide:YES];
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
#pragma mark - View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        dataList=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    notificationView = [[GCDiscreetNotificationView alloc]
                        initWithText:@"私信加载中"
                        showActivity:YES
                        inPresentationMode:GCDiscreetNotificationViewPresentationModeBottom
                        inView:self.view];
    [self getData];
}

- (void)viewDidUnload
{
    [self setTab:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [notificationView release];
    [tab release];
    [request release];
    [dataList release];
    [super dealloc];
}


- (IBAction)onNav:(id)sender {
    if ([sender tag]==101) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] onleft];
    }
    if ([sender tag]==102) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] onright];
    }
}


@end
