//
//  FootprintViewController.h
//  Travel
//
//  Created by home auto on 12-8-20.
//  Copyright (c) 2012年 st. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAMapKit.h"
@interface FootprintViewController : UIViewController<MAMapViewDelegate>
{

    MAMapView *myMapView;
}
- (IBAction)onAdd:(id)sender;
- (IBAction)onBack:(id)sender;
@end
