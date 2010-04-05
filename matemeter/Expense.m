//
//  Expense.m
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "Expense.h"


@implementation Expense

@synthesize cost;
@synthesize description;
@synthesize date;
@synthesize rating;


-(id) init {
	if (self = [super init]){
	}
	return self;
}

-(void) dealloc {
	[cost release];
	[description release];
	[date release];
	[rating release];
	[super dealloc];
}

@end

