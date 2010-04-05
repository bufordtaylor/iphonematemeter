//
//  Mate.h
//  matemeter
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Category;


@interface Mate : NSObject {
	int ID;
	NSString* name;
	NSString* sex;
	NSString* age;
	NSString* relation;
	NSDate* start_date;
	Category* category;
	
	
	NSMutableArray* expenses;
	
	
	NSDate* dateModified;

}

@property (readwrite) int ID;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* sex;
@property (nonatomic, retain) NSString* age;
@property (nonatomic, retain) NSString* relation;
@property (nonatomic, retain) NSDate* start_date;
@property (nonatomic, retain) Category* category;

@property (nonatomic, retain) NSDate* dateModified;
@property (nonatomic, retain) NSMutableArray* expenses;

extern NSString *const RELATION_FRIENDS;
extern NSString *const RELATION_EXCLUSIVELY_DATING;
extern NSString *const RELATION_CASUALLY_DATING;

-(id) initWithID:(int)i;
-(void) updateDateModified;


@end
