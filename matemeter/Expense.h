//
//  Expense.h
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expense : NSObject {
	NSDecimalNumber* cost;	
	NSString* description;
	NSDate* date;
	NSDecimalNumber* rating;
}

@property (nonatomic, retain) NSDecimalNumber* cost;
@property (nonatomic, retain) NSString* description
;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) NSDecimalNumber* rating;

@end
