//
//  DBHelper.h
//  Travel
//
//  Created by 王俊 on 13-1-20.
//
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>
#import "HttpCacheDB.h"
#import "FMDatabase.h"

@interface DBHelper : NSObject
{
    FMDatabase  *database;     //数据库
    HttpCacheDB *httpCacheDB;  //网络缓存数据库
}
/*!
 @class
 @abstract 数据库
 */
@property (nonatomic, retain) FMDatabase *database;

/*!
 @method
 @abstract   创建一个数据库引擎
 @discussion 返回指针不释放
 @result     返回创建的DBHelper
 */
+(DBHelper *)staticInstance;

/*!
 @method
 @abstract   打开数据库
 @discussion 数据库不存在时会自动创建
 */
- (void)Open;

/*!
 @method
 @abstract   创建数据表
 @discussion 不检查路径和文件存在性
 @param      db 要创建表的数据库
 @result     成功和失败都返回YES，不处理异常
 */
- (BOOL)CreateTable:(FMDatabase *)db;

/*!
 @class
 @abstract 网络缓存数据库
 */
@property(nonatomic, assign)HttpCacheDB *httpCacheDB;

@end
