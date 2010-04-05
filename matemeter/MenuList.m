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
		mate = [m retain];
		if (!mate){
			mate = (Mate*)[[Services services] dm].currentMate;
		}
		self.title = mate.name;
		UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"Mates" 
																		style:UIBarButtonItemStyleBordered	 
																	   target:self	 
																	   action:@selector(backToMates:)] autorelease];
		self.navigationItem.leftBarButtonItem = backButton;
	}
	return self;
	
}

-(void) dealloc {
	[super dealloc];
}

- (void)backToMates:(id)sender {
	[self.navigationController pushViewController:[[[MateListVC alloc] init] autorelease] animated:YES]; 
	
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
	NSLog(@"here");
	NSString* categoryTitle = (NSString*)[[[mate.category categoryNames]  keys] objectAtIndex:indexPath.row];
	NSLog(@"Selected %@", categoryTitle);
	if ([categoryTitle isEqualToString:@"Expenses"]) {
		[self.navigationController pushViewController:[[[ExpenseList alloc] initWithMate:mate] autorelease] animated:YES];
	}

	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}

@end
