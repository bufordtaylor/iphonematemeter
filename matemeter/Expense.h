//
//  Expense.h
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expense : NSObject {
	int ID;
	int mateID;
	int cost;	
	NSString* description;
	NSDate* date;
	int rating;
}

@property (readwrite) int ID;
@property (readwrite) int mateID;

@property (readwrite) int cost;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSDate* date;
@property (readwrite) int rating;

-(NSString*) date;

@end
