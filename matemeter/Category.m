//
//  Category.m
//  matemeter
//
//  Created by Buford Taylor on 3/16/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "Category.h"
#import "Mate.h"
#import "BucketedHash.h"
#import "Services.h"
#import "DataManager.h"

@implementation Category

@synthesize categoryNames;
@synthesize rows;
@synthesize sections;

-(id) initWithMate:(Mate*)m {
	if (self = [super init]) {
		categoryNames = [[BucketedHash alloc] initWithCapacity:3 ];
		[self setupWithMate:m];
	}
	return self;
}

-(void) dealloc {
	[sections release];
	[rows release];
	[categoryNames release];
	[super dealloc];
}

-(void) setupWithMate:(Mate*)m {
	
	NSString* expenseCount = [NSString stringWithFormat:@"(%d)", (int)[[[Services services] dm].currentMate.expenses count]];
	
	if ([m.relation isEqualToString:@"exclusively dating"]) {
		NSString* subtitle = @"0 entries"; //THIS WILL EVENTUALLY BE AN IMAGE
		[categoryNames addObject:subtitle toKey:@"Social Circle"];
		[categoryNames addObject:expenseCount toKey:@"Expenses"];
		
		NSString* subtitle3 = @"2 entries";
		[categoryNames addObject:subtitle3 toKey:@"Sex Life"];
		
		
		rows = [NSNumber numberWithInt:[categoryNames numKeys]];
		sections = [NSNumber numberWithInt:1];
		
	//////////////////////////CASUALLY DATING//////////////////////////////	
	} else if ([m.relation isEqualToString:@"casually dating"]) {
		[categoryNames addObject:expenseCount toKey:@"Expenses"];
		
		NSString* subtitle3 = @"2 entries";
		[categoryNames addObject:subtitle3 toKey:@"Sex Life"];
		rows = [NSNumber numberWithInt:[categoryNames numKeys]];
		sections = [NSNumber numberWithInt:1];
		
		
	//////////////////////////////FRIENDS////////////////////////////////	
	} else if ([m.relation isEqualToString:@"friends"]) {
		[categoryNames addObject:expenseCount toKey:@"Expenses"];
		
		rows = [NSNumber numberWithInt:[categoryNames numKeys]];
		sections = [NSNumber numberWithInt:1];
	}
}

-(NSNumber*) rows {
	return rows;
}

-(NSNumber*) sections {
	return sections;
}

-(BucketedHash*) categoryNames {
	return categoryNames;
}

@end
