//
//  Friend.m
//  matemeter
//
//  Created by Buford Taylor on 4/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "Friend.h"


@implementation Friend
@synthesize fId, name, phoneNumber;

-(id) initWithId:(int)i name:(NSString *)n phoneNumber:(NSString *)pn {
	if(self = [super init]){
		self.fId = i;
		self.name = n;
		self.phoneNumber = pn;
	}
	return self;
}

@end
