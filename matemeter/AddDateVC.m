//
//  AddDateVC.m
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddDateVC.h"
#import "Expense.h"
#import "Social.h"
#import "Sex.h"
#import "General.h"
#import "AddDateCell.h"
#import "AddNewExpenseForm.h"



@implementation AddDateVC

-(id) init {
	if (self = [super init]) {
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

-(id) initWithExpense:(Expense *)e {
	if (self = [super init]) {
		expense = [e retain];
		self = [self init];
	}
	return self;
}

-(id) initWithSocial:(Social *)s {
	if (self = [super init]) {
		social = [s retain];
		self = [self init];
	}
	return self;
}

-(id) initWithSex:(Sex *)s {
	if (self = [super init]) {
		sex = [s retain];
		self = [self init];
	}
	return self;
}

-(id) initWithGeneral:(General *)g {
	if (self = [super init]) {
		general = [g retain];
		self = [self init];
	}
	return self;
}


-(void) dealloc {
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
	if(social) {
		social.date = [[cell datepicker] date];
	}
	if(sex) {
		sex.date = [[cell datepicker] date];
	}
	if(general) {
		general.date = [[cell datepicker] date];
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
	if (social) {
		NSDate *dDate = social.date;
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterNoStyle];
		NSString *strDate = [formatter stringFromDate:dDate];
		
		[cell setup:strDate date:social.date];
		[formatter release];
	}
	if (sex) {
		NSDate *dDate = sex.date;
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterNoStyle];
		NSString *strDate = [formatter stringFromDate:dDate];
		
		[cell setup:strDate date:sex.date];
		[formatter release];
	}
	
	if (general) {
		NSDate *dDate = sex.date;
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterNoStyle];
		NSString *strDate = [formatter stringFromDate:dDate];
		
		[cell setup:strDate date:general.date];
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
