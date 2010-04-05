//
//  BucketedHash.h
//  matemeter
//
//  Created by Buford Taylor on 3/16/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BucketedHash : NSObject {
	NSMutableDictionary* dict;
	NSMutableArray* keys;
}

-(id) initWithCapacity:(int)cap;
-(NSArray*) elementsForKey:(NSString*)key;
-(NSArray*) elementsForKeyIndex:(int)i;
-(void) addObject:(id)obj toKey:(NSString*)key;
-(NSArray*) keys;
-(int) numKeys;
-(void) alphaSortKeys;
-(NSString*) indexToKey:(int)i;

@end
