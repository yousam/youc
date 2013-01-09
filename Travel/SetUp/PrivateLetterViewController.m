//
//  PrivateLetterViewController.m
//  Travel
//
//  Created by 王颖 on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrivateLetterViewController.h"
#import "ActivityIndicatorView.h"
#import "AppDelegate.h"
#import "PrivteCell.h"
#import "JSON.h"
#import "HeadIntegrate.h"

@implementation PrivateLetterViewController
@synthesize tab;



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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
    [ASIFormDataRequest setShouldUpdateNetworkActivityIndicator:NO];
	request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setRequestMethod:@"GET"];
    [request setDidFinishSelector:@selector(requestNewsList:)];
    [request setThreadPriority:1];
	[request startAsynchronous];
}

- (void)requestNewsList:(ASIHTTPRequest *)aRequest
{
    NSString *responseString = [aRequest responseString];
    NSDictionary *body= [[responseString JSONValue]objectForKey:@"body"];
    [dataList removeAllObjects];
    [dataList addObjectsFromArray:[body objectForKey:@"cityList"]];
    [tab reloadData];
    [self.view stopLoadingAnimation];
}

- (void)requestFailed:(ASIHTTPRequest *)aRequest
{
    [self.view stopLoadingAnimation];
}


- (void)requestStarted:(ASIHTTPRequest *)aRequest
{
    [self.view startLoadingAnimation];
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
    [tab release];
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
