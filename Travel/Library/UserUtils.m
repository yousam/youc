//
//  UserUtils.m
//  Travel
//
//  Created by nan xiaobin on 13-1-15.
//
//

#import "UserUtils.h"

@implementation UserUtils 

@synthesize userName, userPsw;
@synthesize userId;
@synthesize loginDate; 

+(NSString *)getUserName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"UserName"];
}

+(int )getUserId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"UserId"];
}

+(bool)setUserName:(NSString *)userName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"UserName"];
    
    return YES;
}

+(bool)setUserId:(int )userId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:userId forKey:@"UserId"];
    
    return YES;
}

@end
