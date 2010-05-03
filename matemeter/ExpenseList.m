//
//  ExpenseList.m
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//


#import "ExpenseList.h"
#import "Mate.h"
#import "AddNewMateCell.h"
#import "AddNewExpenseForm.h"
#import "MenuList.h"
#import "MateCell.h"
#import "Services.h"
#import "DataManager.h"


@implementation ExpenseList

-(id) initWithMate:(Mate *)m {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		mate = [[Services services] dm].currentMate;
		self.title = @"Expenses";
		UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" 
																		style:UIBarButtonItemStyleBordered	 
																	   target:self	 
																	   action:@selector(tapCancel)] autorelease];
		self.navigationItem.leftBarButtonItem = backButton;
	}
	return self;
	
}

-(void) dealloc {
	[super dealloc];
}


-(BOOL) isAddIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 1 && indexPath.row == 0){
		return YES;
	}
	return NO;
}

-(void) tapCancel {
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) viewWillAppear:(BOOL)animated {
	[[[Services services] dm] populateExpensesFromMateID:mate.ID];
	[[Services services] dm].currentExpense = nil;
	[self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 1) {
		return 1;
	}
	return [mate.expenses count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSMutableArray* expenses = mate.expenses;
	NSLog(@"expense count = %d", [expenses count]);
	
	
	if([self isAddIndexPath:indexPath]){
		static NSString* AddNewMateCellIden = @"AddNewMateCellIden";
		AddNewMateCell* cell = (AddNewMateCell*)[tableView dequeueReusableCellWithIdentifier:AddNewMateCellIden];
		if (!cell) {
			cell = [[[AddNewMateCell alloc] initWithReuseIdentifier:AddNewMateCellIden] autorelease];
		}
		[cell changeTextTo:[NSString stringWithFormat:@"Add Expense"]];
		return cell;
	}
	
	Expense* ex = (Expense*)[expenses objectAtIndex:indexPath.row];
	static NSString* ExpenseCellIden = @"ExpenseCellIden";
	MateCell* cell = (MateCell*)[tableView dequeueReusableCellWithIdentifier:ExpenseCellIden];
	if (!cell) {
		cell = [[[MateCell alloc] initWithReuseIdentifier:ExpenseCellIden] autorelease];
	}
	[cell setupWithExpense:ex];
	return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([mate.expenses count] > 0 && ![self isAddIndexPath:indexPath]) {
		Expense* expense = [[[Services services] dm].currentMate.expenses objectAtIndex:indexPath.row];
		[[Services services] dm].currentExpense = expense;
		[self.navigationController pushViewController:[[[AddNewExpenseForm alloc] initWithExpense:expense] autorelease] animated:YES];
	}
	
	if([self isAddIndexPath:indexPath]){
		[self.navigationController pushViewController:[[[AddNewExpenseForm alloc] initWithMate:mate] autorelease] animated:YES];
	}
	
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self isAddIndexPath:indexPath]){ return 25; }
	return 75;
}

@end