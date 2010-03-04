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

-(id) init {
	if (self = [super init]){
		name = nil;
		sex = nil;
		start_date = nil;
		age = nil;
		relation = nil;
	}
	return self;
}

-(void) dealloc {
	[name release];
	[sex release];
	[start_date release];
	[age release];
	[relation release];
	[super dealloc];
}


@end
