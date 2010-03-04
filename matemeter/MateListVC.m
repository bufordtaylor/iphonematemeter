//
//  MateListVC.m
//  Buford Taylor
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MateListVC.h"
#import "AddNewMateCell.h"
#import "AddNewMateFormVC.h"

@implementation MateListVC

-(id) init {
	if (self = [super init]) {
		self.title = @"Current Mates";
		UIBarButtonItem* profileBtn = [[[UIBarButtonItem alloc] init] autorelease];
		profileBtn.title = @"Profile";
		self.navigationItem.rightBarButtonItem = profileBtn;
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(BOOL) isAddMateIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0 && indexPath.row == 0){
		return YES;
	}
	return NO;
}


-(void) viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if([self isAddMateIndexPath:indexPath]){
		static NSString* AddNewMateCellIden = @"AddNewMateCellIden";
		AddNewMateCell* cell = (AddNewMateCell*)[tableView dequeueReusableCellWithIdentifier:AddNewMateCellIden];
		if (!cell) {
			cell = [[[AddNewMateCell alloc] initWithReuseIdentifier:AddNewMateCellIden] autorelease];
		}
		return cell;
	}
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"here");
	if([self isAddMateIndexPath:indexPath]){
		[self.navigationController pushViewController:[[[AddNewMateFormVC alloc] init] autorelease] animated:YES];
	}
	

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 25;
}


@end
