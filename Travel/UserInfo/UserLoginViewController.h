//
//  UserLoginViewController.h
//  Travel
//
//  Created by nan xiaobin on 13-1-15.
//
//

#import <UIKit/UIKit.h>

@interface UserLoginViewController : UIViewController{
    
}

@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UITextField *txtPsw;

- (IBAction)onBack:(id)sender;
- (IBAction)logining:(id)sender;


@end
