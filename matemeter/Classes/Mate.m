//
//  Mate.m
//  matemeter
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Mate.h"


@implementation Mate

@synthesize name;
@synthesize sex;
@synthesize start_date;
@synthesize age;
@synthesize relation;
@synthesize category;
@synthesize dateModified;
@synthesize expenses;
@synthesize ID;

NSString *const RELATION_FRIENDS = @"friends";
NSString *const RELATION_EXCLUSIVELY_DATING = @"exclusively dating";
NSString *const RELATION_CASUALLY_DATING = @"casually dating";

-(id) init {
	if (self = [super init]){
		expenses = [[NSMutableArray alloc] init];
	}
	return self;
}

-(id) initWithID:(int)i {
	if (self = [super init]){
		expenses = [[NSMutableArray alloc] init];
		self.ID = i;
	}
	return self;	
}

-(void) dealloc {
	[name release];
	[sex release];
	[start_date release];
	[age release];
	[relation release];
	[dateModified release];
	[expenses release];
	[super dealloc];
}

-(void) updateDateModified {
	self.dateModified = [NSDate date];
}


@end
