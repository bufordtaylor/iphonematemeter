//
//  AddNewMateFormVC.m
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewMateFormVC.h"
#import "AddNewMateForm.h"
#import "Mate.h"
#import "Services.h"
#import "DataManager.h"
#import "MenuList.h"
#import "Category.h"

#define kOFFSET_FOR_KEYBOARD 0.0

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
		saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tapSave)];
		saveBtn.title = @"Save";
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(void) tapSave {
	NSString* sex = [mateForm.sexInput titleForSegmentAtIndex: [mateForm.sexInput selectedSegmentIndex]];
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	NSString* date = [dateFormatter stringFromDate:[mateForm.dateInput date]];
	
	Mate* mate = [[[Mate alloc] init] autorelease];
	mate.sex = sex;
	mate.start_date = [mateForm.dateInput date];
	mate.name = mateForm.nameInput.text;
	mate.age = mateForm.ageInput.text;
	mate.relation = mateForm.relationLabel.text;
	
	Category* category = [[[Category alloc] initWithMate:mate] autorelease];
	
	mate.category = category;
	[mate updateDateModified];
	NSString* modified = [dateFormatter stringFromDate:mate.dateModified];
	
	[[[Services services] dm].mates addObject:mate];
	NSLog(@"%d mates right now", [[[Services services] dm].mates count]);
	
	[[Services services] dm].currentMate = mate;
	
	[self.navigationController pushViewController:[[[MenuList alloc] initWithMate:mate] autorelease] animated:YES];
	
	
	
	
	NSLog(@"name = %@, age = %@, relation = %@, sex = %@, date = %@, modified= %@", mateForm.nameInput.text, mateForm.ageInput.text, mateForm.relationLabel.text, sex, date, modified);
}

-(void) tapDone {
	if ([mateForm.nameInput isFirstResponder]) [mateForm.nameInput resignFirstResponder];
	if ([mateForm.ageInput isFirstResponder]) [mateForm.ageInput resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
	NSString* name = mateForm.nameInput.text;
	NSString* age = mateForm.ageInput.text;
	if(name && age && ([[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)  && ([[age stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)){
		self.navigationItem.rightBarButtonItem = saveBtn;
	}
}


-(void) showDoneButton {
	UIBarButtonItem* doneBtn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tapDone)] autorelease];
	doneBtn.title = @"Done Typing";
	self.navigationItem.rightBarButtonItem = doneBtn;
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
		[mateForm.sexInput addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventValueChanged];
	}
	return mateForm;
}


-(void) sexAction:(UISegmentedControl*)sender {
	UISegmentedControl* segmentedControl = (UISegmentedControl*) sender;
	NSLog(@"picked %@", [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]]);
	
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
    [UIView setAnimationDuration:1.0]; // if you want to slide up the view
	
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
	[self showDoneButton];
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
