//
//  AddDateCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddDateCell.h"


@implementation AddDateCell


-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddDate" reuseIdentifier:ri]){
		lbl.textAlignment = UITextAlignmentCenter;
		
		datepicker.datePickerMode = UIDatePickerModeDate;
		datepicker.hidden = NO;
		
	}
	return self;
}

-(void) dealloc {
	[datepicker release];
	[lbl release];
	[super dealloc];
}

-(void) setup:(NSString*)defaultLbl date:(NSDate*) date {
	datepicker.date = date;
	lbl.text = defaultLbl;
}

-(UIDatePicker*) datepicker {
	return datepicker;
}

-(UILabel*) lbl {
	return lbl;
}

@end