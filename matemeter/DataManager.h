//
//  DateManager.h
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class Mate;
@class Expense;


@interface DataManager : NSObject {
	NSMutableArray* mates;
	Mate* currentMate;
	
	NSMutableArray* expenses;
	Expense* currentExpense;
	
	NSString* dbPath;
	NSString* dbName;
}

-(void)insertMate:(NSString*)name age:(NSString*)age relation:(NSString*)relation sex:(NSString*)sex date:(NSString*)date;
-(void) populateMates;
-(void) populateExpensesWithMateID:(int)_id;

@property (nonatomic, retain) NSMutableArray* mates;
@property (nonatomic, retain) Mate* currentMate;
@property (nonatomic, retain) NSMutableArray* expenses;
@property (nonatomic, retain) Expense* currentExpense;
@property (readwrite, copy) NSString* dbPath;

@end
