//
//  ActivityIndicatorView.m
//  letao
//
//  Created by haoxu on 11-8-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "SingletonState.h"

#pragma mark loading animation

@implementation UIView(add_loading_animation)

-(void) startLoadingAnimation{

	SingletonState* mySingle = [SingletonState sharedStateInstance];
	self.userInteractionEnabled = YES;
	[self addSubview:mySingle.ui_activityViewBg];
	
	[mySingle.activityView startAnimating];
}

-(void) stopLoadingAnimation{
	self.userInteractionEnabled = YES;
	[[SingletonState sharedStateInstance].ui_activityViewBg removeFromSuperview];
}

@end
