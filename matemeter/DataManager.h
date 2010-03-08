//
//  DateManager.h
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mate;


@interface DataManager : NSObject {
	NSMutableArray* mates;
}

@property (nonatomic, retain) NSMutableArray* mates;

@end
