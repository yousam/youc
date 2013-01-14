//
//  UserInfoViewController.m
//  Travel
//
//  Created by home auto on 12-8-19.
//  Copyright (c) 2012年 st. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "AttentionViewController.h"
#import "TripViewController.h"
#import "CollectionViewController.h"
#import "FansViewController.h"
#import "ReplyViewController.h"
#import "HeadIntegrate.h"
#import "GCDiscreetNotificationView.h"
#import "NSString+URLEncoding.h"
#import "JSONKit.h"

@implementation UserInfoViewController
@synthesize mainView;
@synthesize request,notificationView;

@synthesize headImg;
@synthesize coverImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            
   }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initButton];
    
    self.navigationController.navigationBarHidden=YES;
    notificationView = [[GCDiscreetNotificationView alloc]
                        initWithText:@"数据加载中"
                        showActivity:YES
                        inPresentationMode:GCDiscreetNotificationViewPresentationModeBottom
                        inView:self.view];
    [self getData];

    
    
    self.headImg.layer.masksToBounds=YES;      
    self.headImg.layer.borderWidth=5;      
    self.headImg.layer.borderColor=[[UIColor whiteColor] CGColor];  
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidAppear:(BOOL)animated{
    
    
}


- (void)viewDidUnload
{
    [self setCoverImg:nil];
    [self setHeadImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserInfoCell" owner:self options:nil];
    UserInfoCell*cell=nil;
    for (id obj in nib) {
        if ([obj isKindOfClass:[UserInfoCell class]]) {
            cell = (UserInfoCell *) obj;
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
} 
- (void)dealloc {
    [mainView release];
    
    [coverImg release];
    [headImg release];
    
    [lblTravelnum release];
    [lblAttentionnum release];
    [lblFansnum release];
    [lblCollectsnum release];
    [lblLeavesnum release];
    [lblName release];
    [lblSigname release];
    
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
- (IBAction)onClick:(id)sender {
    if ([sender tag]==0) {
        TripViewController *user=[[TripViewController alloc]initWithNibName:@"TripViewController" bundle:nil];
        [self.navigationController pushViewController:user animated:YES];
        [user release];
    }
    if ([sender tag]==1) {
        AttentionViewController *user=[[AttentionViewController alloc]initWithNibName:@"AttentionViewController" bundle:nil];
        [self.navigationController pushViewController:user animated:YES];
        [user release];
    }
    if ([sender tag]==2) {
        FansViewController *user=[[FansViewController alloc]initWithNibName:@"FansViewController" bundle:nil];
        [self.navigationController pushViewController:user animated:YES];
        [user release];
    }
    if ([sender tag]==3) {
        CollectionViewController *user=[[CollectionViewController alloc]initWithNibName:@"CollectionViewController" bundle:nil];
        [self.navigationController pushViewController:user animated:YES];
        [user release];
    }
    if ([sender tag]==5) {
        ReplyViewController*reply=[[ReplyViewController alloc] initWithNibName:@"ReplyViewController" bundle:nil];
        [self.navigationController pushViewController:reply animated:YES];
        reply.type=0;
        [reply release];
    }
    if ([sender tag]==6) {
        ReplyViewController*reply=[[ReplyViewController alloc] initWithNibName:@"ReplyViewController" bundle:nil];
        [self.navigationController pushViewController:reply animated:YES];
        reply.type=1;
        [reply release];
    }   
}


#pragma mark - 数据
-(void)getData{
    if (![System connectedToNetwork])
	{
		return;
	}
    [dataList removeAllObjects];
    NSString * strUrl=
    [NSString stringWithFormat:@"%@user?userId=2",
     API_SEAECHSERVER_ADR];
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
        NSDictionary *body= [values objectForKey:@"body"];
        [dataList removeAllObjects];
        [dataList addObjectsFromArray:[body objectForKey:@"cityList"]];
        
        //刷新页面内容
        [lblName setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"username"]]];
        [lblSigname setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"description"]]];
        [lblTravelnum setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"journeyCount"]]];
        [lblAttentionnum setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"followsCount"]]];
        [lblFansnum setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"fansCount"]]];
        [lblCollectsnum setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"favoritesCount"]]];
        [lblLeavesnum setText:[NSString stringWithFormat:@"%@", [[values objectForKey:@"body"] objectForKey:@"replayCount"]]];
        
        
        [self reflashData];
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

#pragma mark - 初始化Button
//初始化Button
-(void)initButton{
    // 定义button公用变量
    int height = 190;   //button.y
    int prefix = 20;
    int padding = 58;
    
    /* 游记button 开始*/
    UIButton *btnTravels = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnTravels setFrame:CGRectMake(prefix, height, 50, 50)];
//    [btnTravels addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:btnTravels];
    
    lblTravelnum = [[UILabel alloc] initWithFrame:CGRectMake(prefix+2, height+3, 46, 20)];
    [lblTravelnum setText:@""];
    [lblTravelnum setFont:[UIFont systemFontOfSize: 12.0]];
    [lblTravelnum setBackgroundColor:[UIColor clearColor]];
    [lblTravelnum setTextAlignment:UITextAlignmentCenter];
    [mainView addSubview:lblTravelnum];
    
    
    UILabel *lblTravels = [[UILabel alloc] initWithFrame:CGRectMake(prefix+2, height+23, 46, 20)];
    [lblTravels setText:@"游记"];
    [lblTravels setFont:[UIFont boldSystemFontOfSize: 14.0]];
    [lblTravels setTextAlignment:UITextAlignmentCenter];
    [lblTravels setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblTravels];
    [lblTravels release];
    /* 游记button 结束*/
    
    
    /* 关注button 开始*/
    UIButton *btnAttention = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnAttention setFrame:CGRectMake(prefix+padding*1, height, 50, 50)];
    [mainView addSubview:btnAttention];
    
    lblAttentionnum = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*1+2, height+3, 46, 20)];
    [lblAttentionnum setText:@""];
    [lblAttentionnum setFont:[UIFont systemFontOfSize: 12.0]];
    [lblAttentionnum setBackgroundColor:[UIColor clearColor]];
    [lblAttentionnum setTextAlignment:UITextAlignmentCenter];
    [mainView addSubview:lblAttentionnum];
    
    UILabel *lblAttention = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*1+2, height+23, 46, 20)];
    [lblAttention setText:@"关注"];
    [lblAttention setFont:[UIFont boldSystemFontOfSize: 14.0]];
    [lblAttention setTextAlignment:UITextAlignmentCenter];
    [lblAttention setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblAttention];
    [lblAttention release];
    /* 关注button 结束*/
    
    /* 粉丝button 开始*/
    UIButton *btnFans = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnFans setFrame:CGRectMake(prefix+padding*2, height, 50, 50)];
    [mainView addSubview:btnFans];
    
    lblFansnum = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*2+2, height+3, 46, 20)];
    [lblFansnum setText:@""];
    [lblFansnum setFont:[UIFont systemFontOfSize: 12.0]];
    [lblFansnum setBackgroundColor:[UIColor clearColor]];
    [lblFansnum setTextAlignment:UITextAlignmentCenter];
    [mainView addSubview:lblFansnum];
    
    UILabel *lblFans = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*2+2, height+23, 46, 20)];
    [lblFans setText:@"粉丝"];
    [lblFans setFont:[UIFont boldSystemFontOfSize: 14.0]];
    [lblFans setTextAlignment:UITextAlignmentCenter];
    [lblFans setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblFans];
    [lblFans release];
    /* 粉丝button 结束*/
    
    /* 收藏button 开始*/
    UIButton *btnCollects = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnCollects setFrame:CGRectMake(prefix+padding*3, height, 50, 50)];
    [mainView addSubview:btnCollects];
    
    lblCollectsnum = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*3+2, height+3, 46, 20)];
    [lblCollectsnum setText:@""];
    [lblCollectsnum setFont:[UIFont systemFontOfSize: 12.0]];
    [lblCollectsnum setBackgroundColor:[UIColor clearColor]];
    [lblCollectsnum setTextAlignment:UITextAlignmentCenter];
    [mainView addSubview:lblCollectsnum];
    
    UILabel *lblCollects = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*3+2, height+23, 46, 20)];
    [lblCollects setText:@"收藏"];
    [lblCollects setFont:[UIFont boldSystemFontOfSize: 14.0]];
    [lblCollects setTextAlignment:UITextAlignmentCenter];
    [lblCollects setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblCollects];
    [lblCollects release];
    /* 收藏button 结束*/
    
    
    /* 留言button 开始*/
    UIButton *btnLeaves = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnLeaves setFrame:CGRectMake(prefix+padding*4, height, 50, 50)];
    [mainView addSubview:btnLeaves];
    
    lblLeavesnum = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*4+2, height+3, 46, 20)];
    [lblLeavesnum setText:@""];
    [lblLeavesnum setFont:[UIFont systemFontOfSize: 12.0]];
    [lblLeavesnum setBackgroundColor:[UIColor clearColor]];
    [lblLeavesnum setTextAlignment:UITextAlignmentCenter];
    [mainView addSubview:lblLeavesnum];
    
    UILabel *lblLeaves = [[UILabel alloc] initWithFrame:CGRectMake(prefix+padding*4+2, height+23, 46, 20)];
    [lblLeaves setText:@"留言"];
    [lblLeaves setFont:[UIFont boldSystemFontOfSize: 14.0]];
    [lblLeaves setTextAlignment:UITextAlignmentCenter];
    [lblLeaves setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblLeaves];
    [lblLeaves release];
    /* 留言button 结束*/
    
    /* 名字lable 开始*/
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(90, 132, 140, 30)];
    lblName.text = @"";
    [lblName setFont:[UIFont systemFontOfSize: 18.0]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblName];
    /* 名字lable 结束*/
    
    /* 签名lable 开始*/
    lblSigname = [[UILabel alloc] initWithFrame:CGRectMake(10, 163, 300, 20)];
    lblSigname.text = @"";
    [lblSigname setFont:[UIFont systemFontOfSize: 12.0]];
    [lblSigname setTextColor:[UIColor grayColor]];
    [lblSigname setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:lblSigname];
    /* 签名lable 结束*/
    
    return;
}
@end
