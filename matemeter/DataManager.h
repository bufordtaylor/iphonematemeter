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


@interface DataManager : NSObject {
	NSMutableArray* mates;
	Mate* currentMate;
	
	NSString* dbPath;
	NSString* dbName;
}

@property (nonatomic, retain) NSMutableArray* mates;
@property (nonatomic, retain) Mate* currentMate;
@property (readwrite, copy) NSString* dbPath;

@end
