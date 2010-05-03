//
//  AddNewMateForm.m
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewMateForm.h"
#import "Services.h"
#import "DataManager.h"


@implementation AddNewMateForm

-(void) dealloc {	
	[dataFailurePopup release];
	[doneButton release];
	[super dealloc];
}

-(void)showError:(NSString*)title msg:(NSString*)msg {
	[dataFailurePopup release];
	dataFailurePopup = [[UIAlertView alloc] initWithTitle:title 
												  message:msg 
												 delegate:self 
										cancelButtonTitle:nil 
										otherButtonTitles:@"OK", nil];
	[dataFailurePopup show];
}


- (void)viewDidLoad {
	
	// create custom button
	doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.tag = 99;
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	[doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
	[doneButton setImage:[UIImage imageNamed:@"downdown.png"] forState:UIControlStateHighlighted];
	[doneButton addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];
	[doneButton retain];
	
	self.nameInput.textAlignment = UITextAlignmentRight;
	self.nameInput.keyboardType = UIKeyboardTypeAlphabet;
	self.nameInput.keyboardAppearance = UIKeyboardAppearanceDefault;
	[self.nameInput setDelegate:self];
	
	self.ageInput.keyboardType = UIKeyboardTypeNumberPad;
	self.ageInput.keyboardAppearance = UIKeyboardAppearanceDefault;
	[self.ageInput setDelegate:self];
	
	self.dateInput.datePickerMode = UIDatePickerModeDate;
	self.dateInput.hidden = NO;
	self.dateInput.date = [NSDate date];
	
	self.relationInput.minimumValue = 0.0;
	self.relationInput.maximumValue = 3.0;
	self.relationInput.tag = 1;
	self.relationInput.value =  1.0;
	self.relationInput.continuous = YES;
	
	self.relationLabel.textColor = [UIColor redColor];
	
	[self.relationInput addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [super viewDidLoad];
}

- (void)cancelInsert {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)completeInsert {
	
	if ([[self.ageInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <= 0) {
		[self showError:@"Missing Field" msg:@"Please Enter an Age"];
		return;
	}
	if ([[self.nameInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <= 0) {
		[self showError:@"Missing Field" msg:@"Please Enter a Name"];
		return;
	}
	
	NSString* sex = [self.sexInput titleForSegmentAtIndex: [self.sexInput selectedSegmentIndex]];
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString* date = [dateFormatter stringFromDate:[self.dateInput date]];
	
	
	NSLog(@"name %@, sex %@, age %@, relation %@, date %@", self.nameInput.text, sex, self.ageInput.text, self.relationLabel.text, date);
	
	[[[Services services] dm] insertMate:self.nameInput.text age:self.ageInput.text relation:self.relationLabel.text sex:sex ddate:date];
	[self dismissModalViewControllerAnimated:YES];
}


- (void)sliderAction:(UISlider*)sender {
	if ([sender value] < 1){
		self.relationLabel.text = @"exclusively dating";
	} else if (([sender value] >= 1) && ([sender value] < 2)){
		self.relationLabel.text = @"casually dating";
	} else {
		self.relationLabel.text = @"friends";
	}
}

- (void)keyboardWillShow:(NSNotification *)notif
{
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	if ([self.ageInput isFirstResponder]){
		// locate keyboard view
		
		UIView* keyboard;
		for(int i=0; i<[tempWindow.subviews count]; i++) {
			keyboard = [tempWindow.subviews objectAtIndex:i];
			// keyboard view found; add the custom button to it
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	} else {
		for(int i=0; i<[tempWindow.subviews count]; i++) {
			if (doneButton.tag == 99) {
				[doneButton removeFromSuperview];
			}
		}
	}

}

-(void) tapDone {
	[self.nameInput resignFirstResponder];
	[self.ageInput resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[self.nameInput resignFirstResponder];
	[self.ageInput resignFirstResponder];
	return YES;
	
}
- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}


-(UITextField*) nameInput{	return nameInput; }
-(UITextField*) ageInput{	return ageInput; }
-(UISegmentedControl*) sexInput{	return sexInput; }
-(UISlider*) relationInput{	return relationInput; }
-(UIDatePicker*) dateInput{	return dateInput; }
-(UILabel*) relationLabel{	return relationLabel; }


@end
