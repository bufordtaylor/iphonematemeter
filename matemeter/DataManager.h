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
@class Social;
@class Sex;
@class General;


@interface DataManager : NSObject {
	NSMutableArray* mates;
	Mate* currentMate;
	
	Expense* currentExpense;
	Social* currentSocial;
	Sex* currentSex;
	General* currentGeneral;
	
	NSString* dbPath;
	NSString* dbName;
}
-(void) checkDatabaseExists;

-(void) insertMate:(NSString*)name age:(NSString*)age relation:(NSString*)relation sex:(NSString*)sex ddate:(NSString*)date;
-(void) insertExpense:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date cost:(int)cost rating:(int)rating;
-(void) insertSocial:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date expand_or_decrease:(NSString*)expand_or_decrease rating:(int)rating;
-(void) insertSex:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating;
-(void) insertGeneral:(int)mate_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating;

-(void) updateExpense:(int)expense_id description:(NSString*)description start_date:(NSString*)start_date cost:(int)cost rating:(int)rating latest:(int)latest;
-(void) updateSocial:(int)social_id description:(NSString*)description start_date:(NSString*)start_date expand_or_decrease:(NSString*)expand_or_decrease rating:(int)rating latest:(int)latest;
-(void) updateSex:(int)sex_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating latest:(int)latest;
-(void) updateGeneral:(int)sex_id description:(NSString*)description start_date:(NSString*)start_date rating:(int)rating latest:(int)latest;

-(void) populateMates;
-(void) populateExpensesFromMateID:(int)_id;
-(void) populateSocialsFromMateID:(int)_id;
-(void) populateSexesFromMateID:(int)_id;
-(void) populateGeneralsFromMateID:(int)_id;

-(void) storeUser:(NSString*)un pass:(NSString*)pw;
-(void) storeUserId:(NSString*)uid;
-(NSString*) username;
-(NSString*) password;
-(NSString*) uid;

@property (nonatomic, retain) NSMutableArray* mates;
@property (nonatomic, retain) Mate* currentMate;
@property (nonatomic, retain) Expense* currentExpense;
@property (nonatomic, retain) Social* currentSocial;
@property (nonatomic, retain) Sex* currentSex;
@property (nonatomic, retain) General* currentGeneral;
@property (readwrite, copy) NSString* dbPath;

@end
