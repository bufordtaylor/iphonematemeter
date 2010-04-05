//
//  DateManager.m
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "DataManager.h"
#import "Mate.h"
#import "Services.h"
#import "Friend.h"

@implementation DataManager

@synthesize mates;
@synthesize currentMate;

@synthesize dbPath;

-(id) init {
		if (self = [super init]) {
			dbName = @"matemeter.sql";
			NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString* documentDirectory = [paths objectAtIndex:0];
			dbPath = [documentDirectory stringByAppendingPathComponent:dbName];
			
			
			mates = [[NSMutableArray alloc] init];
		}
	 return self;
}
			 
-(void) dealloc {
	[currentMate release];
	[mates release];
	[super dealloc];
}


-(void) checkDatabaseExists {
	NSFileManager* fileManager = [NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:dbPath]) return;
	
	NSString* defaultDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
	
	[fileManager copyItemAtPath:defaultDatabasePath toPath:dbPath error:nil];
}

-(void) populateMates {
//CREATE TABLE IF NOT EXISTS mates (
//id INTEGER PRIMARY KEY, 
//name VARCHAR(50) not null, 
//sex VARCHAR(4) not null,
//age VARCHAR(3) not null,
//relation VARCHAR(25) not null,
//start_date date not null    
//);

	sqlite3* database;
	mates = [[NSMutableArray alloc] init];
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "select * from mates";
		sqlite3_stmt* compiled_statement;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled_statement, NULL) == SQLITE_OK){
			while(sqlite3_step(compiled_statement) == SQLITE_ROW){
				int mateID = sqlite3_column_int(compiled_statement, 0);
				NSString* mateName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 1)];
				NSString* mateSex = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 2)];
				NSString* mateAge = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 3)];
				NSString* mateRelation = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 4)];
				NSString* mateDateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 5)];
				
				
				[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

				[dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
				
				NSDate *mateDate = [[NSDate alloc] init];
				mateDate = [dateFormatter dateFromString:mateDateStr];
				
				Mate* m = [[Mate alloc] initWithID:mateID];
				m.name = mateName;
				m.sex = mateSex;
				m.age = mateAge;
				m.relation = mateRelation;
				m.start_date = mateDate;
				[mates addObject:m];
			}
		}
		sqlite3_finalize(compiled_statement);
		sqlite3_close(database);
	}
}


-(void) insertMate {
//CREATE TABLE IF NOT EXISTS mates (
//	id INTEGER PRIMARY KEY, 
//	name VARCHAR(50) not null, 
//	sex VARCHAR(4) not null,
//	age VARCHAR(3) not null,
//	relation VARCHAR(25) not null,
//	start_date date not null    
//);
	
	
	NSString* name = @"Taylor";
	NSString* sex = @"M";
	NSString* age = @"26";
	NSString* relation = @"Dating";
	NSString* date = @"2010-01-01 00:00:00";

	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "INSERT INTO mates (name, sex, age, relation, start_date) values (?,?,?,?,?)";
		
		sqlite3_stmt *add_mate_compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &add_mate_compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(add_mate_compiled, 1, [name UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(add_mate_compiled, 2, [sex UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(add_mate_compiled, 3, [age UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(add_mate_compiled, 4, [relation UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(add_mate_compiled, 5, [date UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(add_mate_compiled);
		}
		sqlite3_finalize(add_mate_compiled);
		sqlite3_close(database);
	}
}


@end




