//
//  Mate.h
//  matemeter
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Mate : NSObject {
	NSString* name;
	NSString* sex;
	NSString* age;
	NSString* relation;
	NSDate* start_date;

}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* sex;
@property (nonatomic, retain) NSString* age;
@property (nonatomic, retain) NSString* relation;
@property (nonatomic, retain) NSDate* start_date;


@end
