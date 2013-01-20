//
//  FootprintViewController.m
//  Travel
//
//  Created by home auto on 12-8-20.
//  Copyright (c) 2012年 st. All rights reserved.
//

#import "FootprintViewController.h"
#import "AddFootprintViewController.h"
@interface FootprintViewController ()

@end

@implementation FootprintViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 44, 320, 420)];
    myMapView.mapType = MAMapTypeStandard;
    myMapView.delegate = self;
    
    CLLocationCoordinate2D center = {39.91669,116.39716};
    MACoordinateSpan span = {0.04,0.03};
    MACoordinateRegion region = {center,span};
    [myMapView setRegion:region animated:NO];
    [self.view addSubview:myMapView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)onAdd:(id)sender {
    AddFootprintViewController *user=[[AddFootprintViewController alloc]initWithNibName:@"AddFootprintViewController" bundle:nil];
    
    [self.navigationController pushViewController:user animated:YES];
    [user release];
}



- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
