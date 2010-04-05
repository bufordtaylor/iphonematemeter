//
//  Friend.h
//  matemeter
//
//  Created by Buford Taylor on 4/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Friend : NSObject {
	
	int fId;
	NSString *name;
	NSString *phoneNumber;

}

@property (readwrite) int fId;
@property (copy, readwrite) NSString* name;
@property (copy, readwrite) NSString* phoneNumber;


-(id) initWithId:(int)i name:(NSString*)n phoneNumber:(NSString*) pn;

@end
