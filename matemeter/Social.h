//
//  Social.h
//  matemeter
//
//  Created by Buford Taylor on 4/22/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Social : NSObject {
	int ID;
	int mateID;
	NSString* expand_or_decrease;	
	NSString* description;
	NSDate* date;
	int rating;
}

@property (readwrite) int ID;
@property (readwrite) int mateID;

@property (nonatomic, retain) NSString* expand_or_decrease;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSDate* date;
@property (readwrite) int rating;

-(NSString*) datestr;

@end
