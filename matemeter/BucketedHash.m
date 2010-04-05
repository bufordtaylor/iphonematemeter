//
//  BucketedHash.m
//  matemeter
//
//  Created by Buford Taylor on 3/16/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "BucketedHash.h"

@implementation BucketedHash

-(id) initWithCapacity:(int)cap {
	if (self = [super init]) {
		dict = [[NSMutableDictionary alloc] initWithCapacity:cap];
		keys = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void) dealloc {
	[dict release];
	[keys release];
	[super dealloc];
}

-(NSArray*) elementsForKey:(NSString*)key {
	NSArray* lookup = [dict objectForKey:key];
	if (lookup) { return lookup; }
	return [NSArray array];
}

-(void) addObject:(id)obj toKey:(NSString*)key {
	NSMutableArray* ar = [NSMutableArray arrayWithArray:[self elementsForKey:key]];
	[ar addObject:obj];
	[dict setObject:ar forKey:key];
	if (![keys containsObject:key]) {
		[keys addObject:key];
	}
}

-(NSArray*) keys {
	return keys;
}

-(int) numKeys {
	return [keys count];
}

-(void) alphaSortKeys {
	[keys sortUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSString*) indexToKey:(int)i {
	return (NSString*)[keys objectAtIndex:i];
}

-(NSArray*) elementsForKeyIndex:(int)i {
	return [self elementsForKey:[self indexToKey:i]];
}


@end
