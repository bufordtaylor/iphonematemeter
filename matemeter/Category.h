//
//  Category.h
//  matemeter
//
//  Created by Buford Taylor on 3/16/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mate;
@class BucketedHash;

@interface Category : NSObject {
	NSNumber* sections;
	NSNumber* rows;
	BucketedHash* categoryNames;
	

}

@property (nonatomic, retain) BucketedHash* categoryNames;
@property (nonatomic, retain) NSNumber* rows;
@property (nonatomic, retain) NSNumber* sections;

-(id) initWithMate:(Mate*)m;
-(void) setupWithMate:(Mate*)m;

-(NSNumber*) rows;
-(NSNumber*) sections;
-(BucketedHash*) categoryNames;

@end
