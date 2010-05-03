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
#import "Expense.h"
#import "Sex.h"
#import "Social.h"
#import "General.h"

@implementation DataManager

@synthesize mates;
@synthesize currentMate;

@synthesize currentExpense;
@synthesize currentSocial;
@synthesize currentSex;
@synthesize currentGeneral;

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
	[currentExpense release];
	[currentSocial release];
	[currentSex release];
	[currentGeneral release];
	[super dealloc];
}


-(void) storeUser:(NSString*)un pass:(NSString*)pw {
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	if ([un length] == 0) { un = nil; }
	if (!un || ([pw length] == 0)) { pw = nil; }
	[defs setObject:un forKey:@"username"];
	[defs setObject:pw forKey:@"password"];
}

-(void) storeUserId:(NSString*)uid {
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	if ([uid length] == 0) { uid = nil; }
	[defs setObject:uid forKey:@"user_id"];
}

-(NSString*) username {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
}

-(NSString*) password {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
}

-(NSString*) uid {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
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
	[mates release];
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

				[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				
				NSDate *mateDate = [[NSDate alloc] init];
				mateDate = [dateFormatter dateFromString:mateDateStr];
				NSLog(@"Mate date: %@", mateDateStr);
				
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


-(void) populateExpensesFromMateID:(int)_id {
	//	CREATE TABLE expenses (
	//   id INTEGER PRIMARY KEY,
	//   mate_id INTEGER not null,
	//   description VARCHAR(50) not null,
	//   start_date date not null,
	//   cost INTEGER not null,
	//   rating INTEGER not null
	//   );
	//	
	NSLog(@"populateExpensesFromMateID called with id %d", _id);
	sqlite3* database;
	[currentMate.expenses removeAllObjects];
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "select * from expenses where mate_id = ?";
		sqlite3_stmt* compiled_statement;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled_statement, NULL) == SQLITE_OK){
			sqlite3_bind_int(compiled_statement, 1, _id);
			
			while(sqlite3_step(compiled_statement) == SQLITE_ROW){
				int expenseID = sqlite3_column_int(compiled_statement, 0);
				int mateID = sqlite3_column_int(compiled_statement, 1);
				NSString* description = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 2)];
				NSString* rawDate = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 3)];
				int cost = sqlite3_column_int(compiled_statement, 4);
				int rating = sqlite3_column_int(compiled_statement, 5);
				
				[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				
				[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				
				NSDate *expenseDate = [[NSDate alloc] init];
				expenseDate = [dateFormatter dateFromString:rawDate];
				
				Expense* ex = [[Expense alloc] initWithID:expenseID];
				NSLog(@"Expense found with name %@", description);
				ex.description = description;
				ex.mateID = mateID;
				ex.date = expenseDate;
				ex.cost = cost;
				ex.rating = rating;
				[currentMate.expenses addObject:ex];
			}
		}
		sqlite3_finalize(compiled_statement);
		sqlite3_close(database);
	}
}

-(void) populateSocialsFromMateID:(int)_id {
	NSLog(@"populateSocialsFromMateID called with id %d", _id);
	sqlite3* database;
	[currentMate.socials removeAllObjects];
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "select * from social where mate_id = ?";
		sqlite3_stmt* compiled_statement;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled_statement, NULL) == SQLITE_OK){
			sqlite3_bind_int(compiled_statement, 1, _id);
			
			while(sqlite3_step(compiled_statement) == SQLITE_ROW){
				int theID = sqlite3_column_int(compiled_statement, 0);
				int mateID = sqlite3_column_int(compiled_statement, 1);
				NSString* description = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 2)];
				NSString* rawDate = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 3)];
				NSString* expand_or_decrease = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 4)];
				int rating = sqlite3_column_int(compiled_statement, 5);
				
				[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				
				[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				
				NSDate *dDate = [[NSDate alloc] init];
				dDate = [dateFormatter dateFromString:rawDate];
				
				Social* s = [[Social alloc] initWithID:theID];
				NSLog(@"Social found with name %@", description);
				s.description = description;
				s.mateID = mateID;
				s.date = dDate;
				s.expand_or_decrease = expand_or_decrease;
				s.rating = rating;
				[currentMate.socials addObject:s];
			}
		}
		sqlite3_finalize(compiled_statement);
		sqlite3_close(database);
	}
}

-(void) populateSexesFromMateID:(int)_id {
	NSLog(@"populateSexesFromMateID called with id %d", _id);
	sqlite3* database;
	[currentMate.sexes removeAllObjects];
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "select * from sex where mate_id = ?";
		sqlite3_stmt* compiled_statement;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled_statement, NULL) == SQLITE_OK){
			sqlite3_bind_int(compiled_statement, 1, _id);
			
			while(sqlite3_step(compiled_statement) == SQLITE_ROW){
				int theID = sqlite3_column_int(compiled_statement, 0);
				int mateID = sqlite3_column_int(compiled_statement, 1);
				NSString* description = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 2)];
				NSString* rawDate = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 3)];
				int rating = sqlite3_column_int(compiled_statement, 4);
				
				[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				
				[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				
				NSDate *dDate = [[NSDate alloc] init];
				dDate = [dateFormatter dateFromString:rawDate];
				
				Sex* s = [[Sex alloc] initWithID:theID];
				NSLog(@"Sex found with name %@", description);
				s.description = description;
				s.mateID = mateID;
				s.date = dDate;
				s.rating = rating;
				[currentMate.sexes addObject:s];
			}
		}
		sqlite3_finalize(compiled_statement);
		sqlite3_close(database);
	}
}

-(void) populateGeneralsFromMateID:(int)_id {
	NSLog(@"populateGeneralsFromMateID called with id %d", _id);
	sqlite3* database;
	[currentMate.generals removeAllObjects];
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "select * from general where mate_id = ?";
		sqlite3_stmt* compiled_statement;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled_statement, NULL) == SQLITE_OK){
			sqlite3_bind_int(compiled_statement, 1, _id);
			
			while(sqlite3_step(compiled_statement) == SQLITE_ROW){
				int theID = sqlite3_column_int(compiled_statement, 0);
				int mateID = sqlite3_column_int(compiled_statement, 1);
				NSString* description = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 2)];
				NSString* rawDate = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiled_statement, 3)];
				int rating = sqlite3_column_int(compiled_statement, 4);
				
				[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				
				[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				
				NSDate *dDate = [[NSDate alloc] init];
				dDate = [dateFormatter dateFromString:rawDate];
				
				General* g = [[General alloc] initWithID:theID];
				NSLog(@"General found with name %@", description);
				g.description = description;
				g.mateID = mateID;
				g.date = dDate;
				g.rating = rating;
				[currentMate.generals addObject:g];
			}
		}
		sqlite3_finalize(compiled_statement);
		sqlite3_close(database);
	}
}

-(void) insertMate:(NSString*)name age:(NSString*)age relation:(NSString*)relation sex:(NSString*)sex ddate:(NSString*)date {
//CREATE TABLE IF NOT EXISTS mates (
//	id INTEGER PRIMARY KEY, 
//	name VARCHAR(50) not null, 
//	sex VARCHAR(4) not null,
//	age VARCHAR(3) not null,
//	relation VARCHAR(25) not null,
//	start_date date not null    
//);
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

-(void) insertSocial:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date expand_or_decrease:(NSString*)expand_or_decrease rating:(int)rating {
//CREATE TABLE social (
// id INTEGER PRIMARY KEY,
// mate_id INTEGER not null,
// description VARCHAR(50) not null,
// start_date date not null,
// expand_or_decrease VARCHAR(50) not null,
// rating INTEGER not null
// );
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "INSERT INTO social (mate_id, description, start_date, expand_or_decrease, rating) values (?,?,?,?,?)";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 1, [[NSString stringWithFormat:@"%d", mate_id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [expand_or_decrease UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 5, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}

-(void) insertSex:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating {
	//CREATE TABLE sex (
	// id INTEGER PRIMARY KEY,
	// mate_id INTEGER not null,
	// description VARCHAR(50) not null,
	// start_date date not null,
	// rating INTEGER not null
	// );
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "INSERT INTO sex (mate_id, description, start_date, rating) values (?,?,?,?)";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 1, [[NSString stringWithFormat:@"%d", mate_id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}

-(void) insertGeneral:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating {
	//CREATE TABLE general (
	// id INTEGER PRIMARY KEY,
	// mate_id INTEGER not null,
	// description VARCHAR(50) not null,
	// start_date date not null,
	// rating INTEGER not null
	// );
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "INSERT INTO general (mate_id, description, start_date, rating) values (?,?,?,?)";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 1, [[NSString stringWithFormat:@"%d", mate_id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}


-(void) insertExpense:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date cost:(int)cost rating:(int)rating {
//	CREATE TABLE expenses (
//   id INTEGER PRIMARY KEY,
//   mate_id INTEGER not null,
//   description VARCHAR(50) not null,
//   start_date date not null,
//   cost INTEGER not null,
//   rating INTEGER not null
//   );
//	
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "INSERT INTO expenses (mate_id, description, start_date, cost, rating) values (?,?,?,?,?)";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 1, [[NSString stringWithFormat:@"%d", mate_id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", cost] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 5, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}


-(void) updateSocial:(int)_id description:(NSString*)description start_date:(NSString*)start_date expand_or_decrease:(NSString*)expand_or_decrease rating:(int)rating latest:(int)latest {
	NSLog(@" updating social with id %d, %@, %@, %@, %d", _id, description, start_date, expand_or_decrease, rating);
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "UPDATE social set description=?, start_date=?, expand_or_decrease=?, rating=?, latest=? where id=?";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			NSLog(@"here bitches");
			sqlite3_bind_text(compiled, 6, [[NSString stringWithFormat:@"%d", _id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 1, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [expand_or_decrease UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 5, [[NSString stringWithFormat:@"%d", latest] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}


-(void) updateSex:(int)_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating latest:(int)latest {
	NSLog(@" updating sex with id %d, %@, %@, %d", _id, description, start_date, rating);
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "UPDATE sex set description=?, start_date=?, rating=?, latest=? where id=?";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 5, [[NSString stringWithFormat:@"%d", _id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 1, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", latest] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}

-(void) updateGeneral:(int)_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating latest:(int)latest {
	NSLog(@" updating general with id %d, %@, %@, %d", _id, description, start_date, rating);
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "UPDATE general set description=?, start_date=?, rating=?, latest=? where id=?";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 5, [[NSString stringWithFormat:@"%d", _id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 1, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", latest] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}

-(void) updateExpense:(int)expense_id description:(NSString*)description start_date:(NSString*)start_date cost:(int)cost rating:(int)rating latest:(int)latest {
	NSLog(@"%@", start_date);
	sqlite3* database;
	if(sqlite3_open([[dbPath copy] UTF8String], &database) == SQLITE_OK){
		const char *sql_statement = "UPDATE expenses set description=?, start_date=?, cost=?, rating=?, latest=? where id=?";
		
		sqlite3_stmt *compiled;
		if(sqlite3_prepare_v2(database, sql_statement, -1, &compiled, NULL) == SQLITE_OK){
			sqlite3_bind_text(compiled, 6, [[NSString stringWithFormat:@"%d", expense_id] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 1, [description UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 2, [start_date UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 3, [[NSString stringWithFormat:@"%d", cost] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 4, [[NSString stringWithFormat:@"%d", rating] UTF8String], -1, SQLITE_STATIC);
			sqlite3_bind_text(compiled, 5, [[NSString stringWithFormat:@"%d", latest] UTF8String], -1, SQLITE_STATIC);
			sqlite3_step(compiled);
		}
		sqlite3_finalize(compiled);
		sqlite3_close(database);
	}
}

@end




