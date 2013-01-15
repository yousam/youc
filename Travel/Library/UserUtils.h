//
//  UserUtils.h
//  Travel
//
//  Created by nan xiaobin on 13-1-15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UserUtils : NSObject{
    NSString *userName;
    NSString *userPsw;
    int userId;
    NSDate *loginDate;
}

@property(retain, nonatomic)NSString *userName; 
@property(retain, nonatomic)NSString *userPsw;
@property(nonatomic)int userId;
@property(retain, nonatomic)NSDate *loginDate;

+(int )getUserId;
+(NSString *)getUserName;
+(bool)setUserName:(NSString *)userName;
+(bool)setUserId:(int )userId;

@end
