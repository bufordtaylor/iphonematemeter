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
		

	}
	return self;
}

-(id) initWithMate:(Mate*) m {
	if (self = [self init]) {
		[m retain];
		mate = m;
	}
	return self;
}

-(void) showSaveButton {
	if (!([expense.cost isEqual:[NSDecimalNumber notANumber]]) && ([[expense.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)) {
		self.navigationItem.rightBarButtonItem = saveBtn;
	}	
}




-(id) initWithExpense:(Expense*) ex {
	if(self = [self init]){
		[ex retain];
		expense = ex;
		updateExpense = YES;
	}
	return self;
}

-(void) dealloc {

	[expense release];
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
	if (updateExpense) {
		NSMutableArray *discardedItems = [NSMutableArray array];
		[discardedItems addObject:expense];
		[[[Services services] dm].currentMate.expenses removeObjectsInArray:discardedItems];
		[discardedItems release];
	}
	[[[Services services] dm].currentMate.expenses addObject:expense];
	NSLog(@"Form expense count %d", [[[Services services] dm].currentMate.expenses count]);
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) tapDone {
	if ([[costTextCell txtBox] isFirstResponder]) [[costTextCell txtBox] resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
	[self saveInfo];
	expense.cost = [NSDecimalNumber decimalNumberWithString:[costTextCell txtBox].text];
	[self showSaveButton];
	
	NSLog(@"cost is %@", expense.cost);
//	if(name && age && ([[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)  && ([[age stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)){
//		self.navigationItem.rightBarButtonItem = saveBtn;
//	}
}


-(void) saveInfo {
	if (!expense) {
		NSLog(@"Makin' new expense");
		expense = [[Expense alloc] init];
		expense.date = [NSDate date];
		expense.rating = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:11.0f] decimalValue]];
	}
	expense.cost = [NSDecimalNumber decimalNumberWithString:[costTextCell txtBox].text];
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
			
			if (expense) {
				[descriptionTextCell setExistingValue:expense.description];
			}
		}
		return descriptionTextCell;
	}
	
	//Text box to get the cost
	if (indexPath.row == 1 && indexPath.section == 0) {
		static NSString* AddTextCellIden = @"AddTextCell";
		costTextCell = (AddTextCell*)[tableView dequeueReusableCellWithIdentifier:AddTextCellIden];
		if (!costTextCell) {
			NSLog(@"costTextCell is being created");
			costTextCell = [[AddTextCell alloc] initWithReuseIdentifier:AddTextCellIden];
			[costTextCell setTheValues:@"How much did it cost?" txtStart:@"0.00"];
			[costTextCell txtBox].delegate = self;
			[costTextCell txtBox].keyboardType = UIKeyboardTypeNumberPad;
			costTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			if (expense && ![expense.cost isEqual:[NSDecimalNumber notANumber]] ) {
				[costTextCell setExistingValue:[expense.cost stringValue]];
			}
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
		if(expense && [expense.rating intValue] < 11){
			[ratingCell setTheValues:@"How satisfied were you?" valStart:[NSString stringWithFormat:@"%@", expense.rating]];
		}
		return ratingCell;
	}
	
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 2) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddDateVC alloc] initWithExpense:expense] autorelease] animated:YES];
	} else if (indexPath.row == 3) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddRatingVC alloc] initWithExpense:expense] autorelease] animated:YES];
	}
	
}


- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	[self showDoneButton];
}

- (void)viewWillAppear:(BOOL)animated
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


@end
