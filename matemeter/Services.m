//
//  Services.m
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "Services.h"
#import "matemeterAppDelegate.h"
#import "DataManager.h"
#import "ApiManager.h"


@implementation Services

-(id) init {
		if (self = [super init]) {
			dm = [[DataManager alloc] init];
			am = [[ApiManager alloc] init];
		}
	return self;
}

-(void) dealloc {
	[dm release];
	[am release];
	[super dealloc];
}

+(Services*) services {
	return [(matemeterAppDelegate*)[[UIApplication sharedApplication] delegate] services];
}

-(DataManager*) dm {
	return dm;
}

-(ApiManager*) am {
	return am;
}

@end
