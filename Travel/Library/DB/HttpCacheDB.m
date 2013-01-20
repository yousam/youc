//
//  HttpCacheDB.m
//  Travel
//
//  Created by 王俊 on 13-1-20.
//
//

#import "HttpCacheDB.h"
#import "FMDatabaseAdditions.h"

@implementation HttpCacheDB
@synthesize database;

- (NSString*) getData:(NSString *)url
{
    
    return [database stringForQuery:@"select ret from HTTP_Cache where url=? ", url];
}

-(void)removeData:(NSString*)url{
    [database beginTransaction];
	[database executeUpdate:@"delete from HTTP_Cache where url=?", url];
    [database commit];
}
- (void)addDataByUrl:(NSString*)url ret:(NSString*)ret
{
    [database beginTransaction];
	[database executeUpdate:@"delete from HTTP_Cache where url=?", url];
	[database executeUpdate:@"insert into HTTP_Cache(url,ret) values(?,?)", url, ret];
    [database commit];
    
}

@end
