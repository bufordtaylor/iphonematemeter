//
//  MenuList.m
//  matemeter
//
//  Created by Buford Taylor on 3/15/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "MenuList.h"
#import "Mate.h"
#import "MenuCell.h"
#import "Category.h"
#import "BucketedHash.h"
#import "MateListVC.h"
#import "ExpenseList.h"
#import "Services.h"
#import "DataManager.h"


@implementation MenuList

-(id) initWithMate:(Mate *)m {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		mate = (Mate*)[[Services services] dm].currentMate;
		Category* category = [[[Category alloc] initWithMate:mate] autorelease];
		
		mate.category = category;
		
		self.title = mate.name;
		UIBarButtonItem* backBtn = [[[UIBarButtonItem alloc] init] autorelease];
		backBtn.title = @"Mates";
		self.navigationItem.backBarButtonItem = backBtn;
	}
	return self;
	
}

-(void) viewWillAppear:(BOOL)animated {
	[[[Services services] dm] populateExpensesFromMateID:mate.ID];
	NSLog(@"%d expenses", [[[Services services] dm].expenses count]);
	[self.tableView reloadData];
}

-(void) dealloc {
	[super dealloc];
}

- (void)backToMates:(id)sender {
	[self.navigationController popViewControllerAnimated:YES]; 
	
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [[mate.category sections] intValue];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[mate.category rows] intValue];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* MenuCellIden = @"MenuCellIden";
	MenuCell* cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:MenuCellIden];
	if (!cell) {
		cell = [[[MenuCell alloc] initWithReuseIdentifier:MenuCellIden] autorelease];
		[cell setupWithCategory:mate forIndexPath:(NSIndexPath*)indexPath];
	}
	return cell;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString* categoryTitle = (NSString*)[[[mate.category categoryNames]  keys] objectAtIndex:indexPath.row];
	if ([categoryTitle isEqualToString:@"Expenses"]) {
		[self.navigationController pushViewController:[[[ExpenseList alloc] initWithMate:mate] autorelease] animated:YES];
	}

	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}

@end
