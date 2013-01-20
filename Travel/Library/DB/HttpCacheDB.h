//
//  HttpCacheDB.h
//  Travel
//
//  Created by 王俊 on 13-1-20.
//
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>
#import "FMDatabase.h"
@interface HttpCacheDB : NSObject
{
    FMDatabase* database;//网络缓存操作数据库
}
/*!
 @property
 @abstract 网络缓存操作数据库
 */
@property (nonatomic, assign) FMDatabase *database;

/*!
 @method
 @abstract   获得数据
 @discussion 获得数据
 @param      url 要获得数据的url
 @result     查询到的数据
 */
- (NSString*) getData:(NSString*)url;
/*!
 @method
 @abstract   添加数据
 @discussion 通过url判断数据是否存在，如果存在，则删除再添加
 @param      url 要添加数据的url
 @param      ret 要添加数据的url对应的数据
 */
- (void)addDataByUrl:(NSString*)url ret:(NSString*) ret;
-(void)removeData:(NSString*)url;

@end
