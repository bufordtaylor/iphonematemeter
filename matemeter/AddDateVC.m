//
//  AddDateVC.m
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddDateVC.h"
#import "Expense.h"
#import "AddDateCell.h"
#import "AddNewExpenseForm.h"



@implementation AddDateVC

-(id) initWithExpense:(Expense *)e {
	if (self = [super init]) {
		expense = [e retain];
		self.title = @"Add Date";
		UIBarButtonItem* backBtn = [[[UIBarButtonItem alloc] init] autorelease];
		backBtn.title = @"Cancel";
		self.navigationItem.backBarButtonItem = backBtn;
		self.tableView.allowsSelection = false;
		self.tableView.scrollEnabled = NO;
		
		UIBarButtonItem* saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tapSave)];
		saveBtn.title = @"Save";
		self.navigationItem.rightBarButtonItem = saveBtn;
	}
	return self;
	
}

-(void) dealloc {
	[expense release];
	[super dealloc];
}

-(void) tapSave {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	NSString* date = [dateFormatter stringFromDate:[[cell datepicker] date]];
	NSLog(@"Date: %@", date);
	if (expense) {
		expense.date = [[cell datepicker] date];

	}
	[self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 460;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString* AddDateCellIden = @"AddDateCellIden";
	cell = (AddDateCell*)[tableView dequeueReusableCellWithIdentifier:AddDateCellIden];
	if (!cell) {
		cell = [[[AddDateCell alloc] initWithReuseIdentifier:AddDateCellIden] autorelease];
		[[cell datepicker] addTarget:self
					   action:@selector(changeDateInLabel:)
					forControlEvents:UIControlEventValueChanged];
	}
	
	if (expense) {
		NSDate *expenseDate = expense.date;
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterNoStyle];
		NSString *strExpenseDate = [formatter stringFromDate:expenseDate];
		
		[cell setup:strExpenseDate date:expense.date];
		[formatter release];
	}
	
	//[cell changeTextTo:[NSString stringWithFormat:@"Add Expense"]];
	return cell;
}

- (void)changeDateInLabel:(id)sender{
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterLongStyle];
	[formatter setTimeStyle:NSDateFormatterNoStyle];
	
	[cell lbl].text = [formatter stringFromDate:[cell datepicker].date];
	[formatter release];
}
				
				
				
				

@end
