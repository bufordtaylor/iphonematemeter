//
//  DateManager.m
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "DataManager.h"
#import "Mate.h"
#import "Services.h"

@implementation DataManager

@synthesize mates;

-(id) init {
		if (self = [super init]) {
			NSLog(@"dm");
			mates = nil;
		}
	 return self;
}
			 
-(void) dealloc {
	[mates release];
	[super dealloc];
}

@end
