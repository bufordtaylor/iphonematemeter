//
//  AddNewExpenseForm.m
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewExpenseForm.h"
#import "AddTextCell.h"
#import "AddLargeTextCell.h"
#import "Expense.h"
#import "KeyvalCell.h"
#import "AddDateVC.h"
#import "AddRatingVC.h"
#import "ExpenseList.h"
#import "Mate.h"
#import "Services.h"
#import "DataManager.h"

@implementation AddNewExpenseForm

-(id) init {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.title = @"Add Expenses";
		UIBarButtonItem* backBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tapCancel)];
		backBtn.title = @"Cancel";
		self.navigationItem.leftBarButtonItem = backBtn;
		
		//self.tableView.allowsSelection = false;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		self.tableView.scrollEnabled = NO;
		saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tapSave)];
		saveBtn.title = @"Save";
		
		
		doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		doneButton.tag = 99;
		doneButton.frame = CGRectMake(0, 163, 106, 53);
		doneButton.adjustsImageWhenHighlighted = NO;
		[doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"downdown.png"] forState:UIControlStateHighlighted];
		[doneButton addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];
		[doneButton retain];

	}
	mate = [[Services services] dm].currentMate;
	return self;
}

-(id) initWithMate:(Mate*) m {
	if (self = [self init]) {
	}
	return self;
}

-(void) showSaveButton {
	if ((expense.rating < 11) && (expense.cost >= 0) && ([[expense.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)) {
		self.navigationItem.rightBarButtonItem = saveBtn;
	}	
}



-(id) initWithExpense:(Expense*) ex {
	if(self = [self init]){
		expense = [[Services services] dm].currentExpense;
		updateExpense = YES;
	}
	return self;
}

-(void) dealloc {
	[doneButton release];
	[costTextCell release];
	[descriptionTextCell release];
	[dateCell release];
	[super dealloc];
}

-(void) tapCancel {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) tapSave {
	[self saveInfo];
	NSLog(@"Expense id is %d", expense.ID);
	if (updateExpense) {
		[[[Services services] dm] updateExpense:expense.ID description:expense.description start_date:[expense datestr] cost:expense.cost rating:expense.rating latest:0];
	} else {
		[[[Services services] dm] insertExpense:mate.ID description:expense.description start_date:[expense datestr] cost:expense.cost rating:expense.rating];
	}
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) tapDone {
	if ([[costTextCell txtBox] isFirstResponder]) [[costTextCell txtBox] resignFirstResponder];
	if ([[descriptionTextCell txtBox] isFirstResponder]) [[descriptionTextCell txtBox] resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
	[self saveInfo];
	expense.cost = [[costTextCell txtBox].text intValue];
	[self showSaveButton];
	
	NSLog(@"cost is %d", expense.cost);
}


-(void) saveInfo {
	if (!expense) {
		[[Services services] dm].currentExpense = [[Expense alloc] init];
		expense = [[Services services] dm].currentExpense;
		expense.date = [NSDate date];
		expense.rating = 11;
		expense.mateID = mate.ID;
		expense.cost = -1;
	}
	if ([[[costTextCell txtBox].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0) {
		expense.cost = [[costTextCell txtBox].text intValue];
	}
	expense.description = [descriptionTextCell txtBox].text;
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
	return 4;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return 75;
	} else {
		return 50;
	}
	return 300;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//Text box to get the description
	if (indexPath.row == 0 && indexPath.section == 0) {
		static NSString* AddLargeTextCellIden = @"AddLargeTextCellIden";
		descriptionTextCell = (AddLargeTextCell*)[tableView dequeueReusableCellWithIdentifier:AddLargeTextCellIden];
		if (!descriptionTextCell) {
			descriptionTextCell = [[AddLargeTextCell alloc] initWithReuseIdentifier:AddLargeTextCellIden];
			[descriptionTextCell setTheValues:@"Short Description" txtStart:@"Shopping,eating out,etc"];
			[descriptionTextCell txtBox].delegate = self;
			[descriptionTextCell txtBox].keyboardType = UIKeyboardTypeAlphabet;
			descriptionTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		if (expense) {
			[descriptionTextCell setExistingValue:expense.description];
		}
		return descriptionTextCell;
	}
	
	//Text box to get the cost
	if (indexPath.row == 1 && indexPath.section == 0) {
		static NSString* AddTextCellIden = @"AddTextCell";
		costTextCell = (AddTextCell*)[tableView dequeueReusableCellWithIdentifier:AddTextCellIden];
		if (!costTextCell) {
			costTextCell = [[AddTextCell alloc] initWithReuseIdentifier:AddTextCellIden];
			[costTextCell setTheValues:@"How much did it cost?" txtStart:@"0.00"];
			[costTextCell txtBox].delegate = self;
			[costTextCell txtBox].keyboardType = UIKeyboardTypeNumberPad;
			costTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		if (expense && expense.cost >= 0 ) {
			[costTextCell setExistingValue:[NSString stringWithFormat:@"%d", expense.cost]];
		}
		return costTextCell;
	}
	
	
	//Cell to get date
	if (indexPath.row == 2 && indexPath.section == 0) {
		static NSString* KeyValCellIden = @"KeyValCellIden";
		dateCell = (KeyvalCell*)[tableView dequeueReusableCellWithIdentifier:KeyValCellIden];
		NSDate *now = [NSDate date];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterNoStyle];		
		if (!dateCell) {
			dateCell = [[KeyvalCell alloc] initWithReuseIdentifier:KeyValCellIden];
			NSString *strNow = [formatter stringFromDate:now];
			[dateCell setTheValues:@"When did it happen?" valStart:strNow];
		}
		if (expense) {
			NSString *strExpenseDate = [formatter stringFromDate:expense.date];
			[dateCell setTheValues:@"When did it happen?" valStart:strExpenseDate];
		}
		return dateCell;
	}
	
	//Cell to get rating
	if (indexPath.row == 3 && indexPath.section == 0) {
		static NSString* KeyValCellIden = @"KeyValCellIden";
		ratingCell = (KeyvalCell*)[tableView dequeueReusableCellWithIdentifier:KeyValCellIden];
		if (!ratingCell) {
			ratingCell = [[KeyvalCell alloc] initWithReuseIdentifier:KeyValCellIden];
			[ratingCell setTheValues:@"How satisfied were you?" valStart:@"Click to rate"];

			
		}
		if(expense && expense.rating < 11){
			[ratingCell setTheValues:@"How satisfied were you?" valStart:[NSString stringWithFormat:@"%d", expense.rating]];
		}
		return ratingCell;
	}
	
	static NSString* DefaultCellIden = @"DefaultCellIden";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIden];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:DefaultCellIden] autorelease];
	}
	return cell;
	NSLog(@"WE SHOULD NEVER REACH HERE");
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 2) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddDateVC alloc] initWithExpense:expense] autorelease] animated:YES];
	} else if (indexPath.row == 3) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddRatingVC alloc] initWithExpense:expense] autorelease] animated:YES];
	}
	
}


-(void)viewWillAppear:(BOOL)animated
{
	if (expense) {
		[self showSaveButton];
		[self.tableView reloadData];
	}

    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 

}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}



- (void)keyboardWillShow:(NSNotification *)notif
{
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	if ([[costTextCell txtBox] isFirstResponder]){
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
	[self showDoneButton];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {

	return YES;
	
}



@end
