//
//  AddNewMateFormVC.m
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewMateFormVC.h"
#import "AddNewMateForm.h"

#define kOFFSET_FOR_KEYBOARD 30.0

@implementation AddNewMateFormVC

-(id) init {
	if (self = [super init]) {
		self.title = @"Basic Info";
		UIBarButtonItem* backBtn = [[[UIBarButtonItem alloc] init] autorelease];
		backBtn.title = @"Cancel";
		self.navigationItem.backBarButtonItem = backBtn;
		self.tableView.allowsSelection = false;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		self.tableView.scrollEnabled = NO;
		mateForm = nil;
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString* AddNewMateFormIden = @"AddNewMateFormIden";
	mateForm = (AddNewMateForm*)[tableView dequeueReusableCellWithIdentifier:AddNewMateFormIden];
	if (!mateForm) {
		mateForm = [[[AddNewMateForm alloc] initWithReuseIdentifier:AddNewMateFormIden] autorelease];
		mateForm.ageInput.delegate = self;
		mateForm.nameInput.delegate = self;
		
		[mateForm.relationInput addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
		[mateForm.dateInput addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventValueChanged];
		
	}
	
	return mateForm;
}

-(void) dateAction:(UIDatePicker*)sender {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	NSLog(@"changed to %@", [dateFormatter stringFromDate:[sender date]]);
	
}

- (void)sliderAction:(UISlider*)sender {
	if ([sender value] < 1){
		mateForm.relationLabel.text = @"exclusively dating";
	} else if (([sender value] >= 1) && ([sender value] < 2)){
		mateForm.relationLabel.text = @"casually dating";
	} else {
		mateForm.relationLabel.text = @"friends";
	}
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 300;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField { // When the return button is pressed on a textField.
	[textField resignFirstResponder]; // Remove the keyboard from the view.
	return YES; // Set the BOOL to YES.
}


-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:mateForm.nameInput])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
	
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	
    if ([mateForm.nameInput isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (![mateForm.nameInput isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
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

@end
