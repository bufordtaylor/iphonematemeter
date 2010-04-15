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
@synthesize ID;
@synthesize mateID;

-(id) initWithID:(int)_ID {
	if (self = [super init]){
		self.ID = _ID;
	}
	return self;
}

-(void) dealloc {
	[description release];
	[date release];
	[super dealloc];
}

-(NSString*) datestr {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
	NSString* strdate = [dateFormatter stringFromDate:self.date];
	return strdate;
}

@end

