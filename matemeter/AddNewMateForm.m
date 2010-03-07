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
		nameInput.textAlignment = UITextAlignmentRight;
		nameInput.keyboardType = UIKeyboardTypeAlphabet;
		nameInput.keyboardAppearance = UIKeyboardAppearanceAlert;
		
		ageInput.keyboardType = UIKeyboardTypeNumberPad;
		ageInput.keyboardAppearance = UIKeyboardAppearanceAlert;
		
		dateInput.datePickerMode = UIDatePickerModeDate;
		dateInput.hidden = NO;
		dateInput.date = [NSDate date];
		
		relationInput.minimumValue = 0.0;
		relationInput.maximumValue = 3.0;
		relationInput.tag = 1;
		relationInput.value =  0.0;
		relationInput.continuous = YES;
		
		relationLabel.textColor = [UIColor redColor];
		
	}
	return self;
}

-(void) dealloc {	
	[nameInput release];
	[ageInput release];
	[sexInput release];
	[relationInput release];
	[dateInput release];
	[relationLabel release];
	[super dealloc];
}

-(UITextField*) nameInput{	return nameInput; }
-(UITextField*) ageInput{	return ageInput; }
-(UISegmentedControl*) sexInput{	return sexInput; }
-(UISlider*) relationInput{	return relationInput; }
-(UIDatePicker*) dateInput{	return dateInput; }
-(UILabel*) relationLabel{	return relationLabel; }


@end
