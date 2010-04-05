//
//  MateCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "MateCell.h"
#import "Mate.h"
#import "BucketedHash.h"
#import "Category.h"
#import "Expense.h"

@implementation MateCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"MateCell" reuseIdentifier:ri]){
	}
	return self;
}

-(void) dealloc {	
	[mateName release];
	[mateDate release];
	[super dealloc];
}

-(void) setupWithMate:(Mate*)m {
	
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
	
	mateName.text = [NSString stringWithString:m.name];
	mateDate.text = [NSString stringWithString:[dateFormatter stringFromDate:m.start_date]];

}

-(void) setupWithExpense:(Expense*)ex {
	
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
	
	mateName.text = [NSString stringWithString:ex.description];
	mateDate.text = [NSString stringWithString:[dateFormatter stringFromDate:ex.date]];
	
}

@end