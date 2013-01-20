//
//  HomeViewController.m
//  Travel
//
//  Created by 王俊 on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "AddTravelViewController.h"
#import "UrlImageButton.h"
#import "CellView.h"
#import "PSCollectionViewCell.h"
#define kTriggerOffSet 100.0f

/////////////////////////////////////
@interface HomeViewController () 
@end
NSUInteger kNumberOfPages = 0;
/////////////////////////////////////

@implementation HomeViewController
@synthesize scroImg;
@synthesize collectionView;
@synthesize Request=request;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    collectionView = [[PullPsCollectionView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    [self.view addSubview:collectionView];
    collectionView.collectionViewDelegate = self;
    collectionView.collectionViewDataSource = self;
    collectionView.pullDelegate=self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    collectionView.numColsPortrait = 3;
    collectionView.numColsLandscape = 4;
//    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
//    loadingLabel.text = @"Loading...";
//    loadingLabel.textAlignment = UITextAlignmentCenter;
//    collectionView.loadingView = loadingLabel;
    if(!collectionView.pullTableIsRefreshing) {
        collectionView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0];
    }

    items=[[NSMutableArray alloc]init];
     viewControllers=[[NSMutableArray alloc]init];
	_nCount = 1;
	UIButton*addBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.frame=CGRectMake(self.view.center.x, self.view.frame.size.height-150, 30, 30);
    [addBtn addTarget:self action:@selector(onAdd) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:addBtn];
    [self.navigationController.navigationBar setHidden:YES];
    headView=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 130)];
    headView.tag=603;
    scroImg = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, 320, 130)];
    
    self.scroImg.showsHorizontalScrollIndicator = NO;
    self.scroImg.showsVerticalScrollIndicator = NO;
    self.scroImg.scrollsToTop = NO;
    self.scroImg.delegate = self;
    [self.scroImg setBackgroundColor:[UIColor clearColor]];
    self.scroImg.pagingEnabled = YES;
    [headView addSubview:self.scroImg];
    
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    pageControl.center=CGPointMake(headView.center.x, 120);
    pageControl.currentPage = 0;
    [headView addSubview:pageControl];
    self.collectionView.headerView=headView;
    pageSize=10;	
}
//分页请求
-(void)nextPage{
    pageIndex++;
    NSString*strUrl=[NSString stringWithFormat:@"http://yun.youcn.com.cn/home?pageSize=%i&pageIndex=%i",pageSize,pageIndex];
    self.request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];
	[request setDelegate:self];
	[request setRequestMethod:@"GET"];
    [request startAsynchronous];
}
//下来刷新
- (void) refreshTable
{
    [self loadDataSource];
    self.collectionView.pullLastRefreshDate = [NSDate date];
    self.collectionView.pullTableIsRefreshing = NO;
}
//上拉刷新加载更多
- (void) loadMoreDataToTable
{
    [self nextPage];
    self.collectionView.pullTableIsLoadingMore = NO;
}
#pragma mark - PullTableViewDelegate

- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}
- (void)viewDidUnload
{
    [self setCollectionView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    CellView *v = (CellView *)[self.collectionView dequeueReusableView];
    if(v == nil) {
        NSArray *nib =
        [[NSBundle mainBundle] loadNibNamed:@"CellView" owner:self options:nil];
        v = [nib objectAtIndex:0];
    }
    
    v.lbTItle.text=@"测试标题数据";
    [v.picView  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img%i",index+1]]];
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    //    NSDictionary *item = [self.items objectAtIndex:index];
    
    // You should probably subclass PSCollectionViewCell
    float h=0;
    if (index==0) {
        h=100;
    }
    
    else if (index==1) {
        h=200;
    }
    else if (index==2) {
        h=500;
    }
    else if (index==3) {
        h=300;
    }
    else{
        
        h=80;
    }
    return [PSCollectionViewCell heightForViewWithObject:h fontHeight:70 inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    // Do something with the tap
}

- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return 10;
}




- (void)loadDataSource {
    pageIndex=0;
    [self nextPage];
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}


- (void)dealloc
{
    [items release];
    [request cancel];
    [request setDelegate:nil];
    [request release];
     [collectionView release];
    [pageControl release];
    [headView release];
    [scroImg release];
    [super dealloc];
}

-(void)onAdd{

    AddTravelViewController *user=[[AddTravelViewController alloc]initWithNibName:@"AddTravelViewController" bundle:nil];
    [self.navigationController pushViewController:user animated:YES];
    [user release];
}


#pragma mark -
#pragma UIScrollViewDelegate methods


 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {

if (scrollView==scroImg) {
         if (pageControlUsed)
         {
             return;
         }
         CGFloat pageWidth = scrollView.frame.size.width;
         int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
         pageControl.currentPage =page;
         [self loadScrollViewWithPage:page - 1];
         [self loadScrollViewWithPage:page];
         [self loadScrollViewWithPage:page+1];
     }
 }


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
    
    
}

//加载首页三张图
- (void)loadScrollViewWithPage:(int)page{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    // replace the placeholder if necessary
    UrlImageButton *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        CGRect frame = scroImg.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller = [[UrlImageButton alloc]initWithFrame:frame];
        controller.tag=page;//将ID保存到Tag中
        
//        [controller addTarget:self action:@selector(onImgBtn:) forControlEvents:UIControlEventTouchUpInside];
        NSString*imgUrl=@"http://m1.img.libdd.com/farm2/230/B8B0E9408AFD8E057D80F44EEF4789E6_1280_957.jpg";
        [controller setImageFromUrl:NO withUrl:imgUrl];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [scroImg addSubview:controller];
        [controller release];
    }
}
- (IBAction)onNav:(id)sender {
    if ([sender tag]==101) {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] onleft];
    }
    if ([sender tag]==102) {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] onright];
    }
}
#pragma mark ASIHTTPRequestDelegate
- (void)requestStarted:(ASIHTTPRequest *)aRequest
{

}
- (void)requestFinished:(ASIHTTPRequest *)aRequest
{
//    int statusCode = [aRequest responseStatusCode];
    //NSLog(@"%@", [aRequest responseString]);
    NSLog(@"%@", [[NSString alloc] initWithData:[aRequest responseData] encoding:NSUTF8StringEncoding]);
    
    //真实调用接口 联调时放开
//    if ([aRequest.responseString length]!=0&&statusCode==200)
//    {
//        [viewControllers removeAllObjects];
//        NSDictionary*values=[aRequest.responseString JSONValue];
//        if ([values isKindOfClass:[NSDictionary class]]) {
//            NSDictionary*body=[values objectForKey:@"body"];
//            NSArray*imgList=[body objectForKey:@"focuses"];
//            kNumberOfPages=imgList.count;
//            for (unsigned i = 0; i < kNumberOfPages; i++)
//            {
//                [viewControllers addObject:[NSNull null]];
//            }
//            scroImg.contentSize = CGSizeMake(scroImg.frame.size.width * kNumberOfPages, scroImg.frame.size.height);
//            pageControl.numberOfPages = 3;
//            [self loadScrollViewWithPage:0];
//            [self loadScrollViewWithPage:1];
//            
//            [items removeAllObjects];
//            [items addObjectsFromArray:[body objectForKey:@"footmarks"]];
//            [self dataSourceDidLoad];
//
//        }
//     
//    }
     kNumberOfPages=3;
    //测试数据
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
        [viewControllers addObject:[NSNull null]];
    }
    scroImg.contentSize = CGSizeMake(scroImg.frame.size.width * kNumberOfPages, scroImg.frame.size.height);
   
    pageControl.numberOfPages = 3;
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
   [self dataSourceDidLoad];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
}

@end
