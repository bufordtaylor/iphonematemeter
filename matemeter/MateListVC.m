//
//  MateListVC.m
//  Buford Taylor
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MateListVC.h"
#import "AddNewMateCell.h"
#import "AddNewMateForm.h"
#import "AddProfileForm.h"
#import "Services.h"
#import "DataManager.h"
#import "MateCell.h"
#import "MenuList.h"

@implementation MateListVC

-(id) init {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		
		
		self.title = @"Mates";
		UIBarButtonItem* profileBtn = [[[UIBarButtonItem alloc] init] autorelease];
		profileBtn.title = @"Profile";
		profileBtn.target = self;
		profileBtn.action = @selector(tapProfile);
		self.navigationItem.rightBarButtonItem = profileBtn;
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(void) tapProfile {
	AddProfileForm* ivc = [[AddProfileForm alloc] initWithNibName:@"AddProfileForm" bundle:nil];
	[self presentModalViewController:ivc animated:YES];
}

-(BOOL) isAddMateIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 1 && indexPath.row == 0){
		return YES;
	}
	return NO;
}


-(void) viewWillAppear:(BOOL)animated {
	[[[Services services] dm] populateMates];
	NSLog(@"%d mates", [[[Services services] dm].mates count]);
	[self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 1) {
		return 1;
	}
	return [[[Services services] dm].mates count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSArray* mates = [[Services services] dm].mates;
	
	
	if([self isAddMateIndexPath:indexPath]){
		static NSString* AddNewMateCellIden = @"AddNewMateCellIden";
		AddNewMateCell* cell = (AddNewMateCell*)[tableView dequeueReusableCellWithIdentifier:AddNewMateCellIden];
		if (!cell) {
			cell = [[[AddNewMateCell alloc] initWithReuseIdentifier:AddNewMateCellIden] autorelease];
		}
		return cell;
	}
	
	Mate* m = (Mate*)[mates objectAtIndex:indexPath.row];
	static NSString* MateCellIden = @"MateCellIden";
	MateCell* cell = (MateCell*)[tableView dequeueReusableCellWithIdentifier:MateCellIden];
	if (!cell) {
		cell = [[[MateCell alloc] initWithReuseIdentifier:MateCellIden] autorelease];
	}
	[cell setupWithMate:m];
	return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == 0 && [[[Services services] dm].mates count] > 0) {
		Mate* mate = [[[Services services] dm].mates objectAtIndex:indexPath.row];
		[[Services services] dm].currentMate = mate;
		NSLog(@"push MenuList");
		[self.navigationController pushViewController:[[[MenuList alloc] initWithMate:mate] autorelease] animated:YES];
	}

	if([self isAddMateIndexPath:indexPath]){
		NSLog(@"new mate form");
		AddNewMateForm* ivc = [[AddNewMateForm alloc] initWithNibName:@"AddNewMateForm" bundle:nil];
		[self presentModalViewController:ivc animated:YES];
	}
	NSLog(@"wtf!!");

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self isAddMateIndexPath:indexPath]){ return 25; }
	return 75;
}


@end
