//
//  UserLoginViewController.m
//  Travel
//
//  Created by nan xiaobin on 13-1-15.
//
//

#import "UserLoginViewController.h"
#import "UserUtils.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController
@synthesize txtName, txtPsw;

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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logining:(id)sender{
//    NSLog(@"txtName.text=%@",txtName.text);
//    NSLog(@"txtPsw.text=%@",txtPsw.text);
    [UserUtils setUserId:2];
    [UserUtils setUserName:txtPsw.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
