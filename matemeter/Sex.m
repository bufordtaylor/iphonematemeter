//
//  Sex.m
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "Sex.h"


@implementation Sex

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
	NSLog(@"%@", self.date);
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString* strdate = [dateFormatter stringFromDate:self.date];
	return strdate;
}

@end