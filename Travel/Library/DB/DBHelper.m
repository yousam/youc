//
//  DBHelper.m
//  Travel
//
//  Created by 王俊 on 13-1-20.
//
//

#import "DBHelper.h"
#import "System.h"

static DBHelper *staticInstance = nil;
@implementation DBHelper
@synthesize database;
@synthesize httpCacheDB;

-(BOOL)doCreateTable:(FMDatabase *)db sql:(NSString *)sql
{
    return [db executeUpdate:sql, nil];
}

- (BOOL)CreateTable:(FMDatabase *)db
{
    
	// table 1
	NSString *sqlhttpcache = @"create table IF NOT EXISTS HTTP_Cache(\
    MId INTEGER PRIMARY KEY AUTOINCREMENT, \
    url text,\
    ret text,\
    flag interger defaulte (0),\
    time vchar(100))";
    [self doCreateTable:db sql:sqlhttpcache];
    return YES;
}

- (void)Open
{
    if (database != nil)
    {
        return;
    }
	NSString *path =[[System getDocumentDirectory] stringByAppendingPathComponent:@"traveldb.db"];
    
    self.database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        return;
    }
    
    [self CreateTable:database];
    
    
    //  create dbtable private instance
    httpCacheDB=[[HttpCacheDB alloc] init];
    httpCacheDB.database=self.database;
}


+(DBHelper *)staticInstance {
	@synchronized(self) {
		if (staticInstance == nil) {
			staticInstance = [[self alloc] init];
			[staticInstance Open];
		}
	}
	return staticInstance;
}

-(void) dealloc{
    [httpCacheDB release];
    [database close];
    [database release];
	[super dealloc];
}
@end

