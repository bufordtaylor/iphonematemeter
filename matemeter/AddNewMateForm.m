//
//  AddNewMateForm.m
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewMateForm.h"


@implementation AddNewMateForm

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddNewMateForm" reuseIdentifier:ri]){
	}
	return self;
}

-(void) dealloc {	
	[nameInput release];
	[ageInput release];
	[sexInput release];
	[startMonthInput release];
	[startYearInput release];
	[relationInput release];
	[super dealloc];
	
}

@end
