//
//  GeneralList.m
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "GeneralList.h"
#import "Mate.h"
#import "AddNewMateCell.h"
#import "AddNewExpenseForm.h"
#import "AddNewSocialForm.h"
#import "AddNewSexForm.h"
#import "AddNewGeneralForm.h"
#import "MenuList.h"
#import "MateCell.h"
#import "Services.h"
#import "DataManager.h"


@implementation GeneralList

-(id) initWithMate:(Mate *)m {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		mate = [[Services services] dm].currentMate;
		self.title = @"General Experiences";
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
	[[[Services services] dm] populateGeneralsFromMateID:mate.ID];
	[[Services services] dm].currentGeneral = nil;
	[self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 1) {
		return 1;
	}
	return [mate.generals count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSMutableArray* generals = mate.generals;
	
	if([self isAddIndexPath:indexPath]){
		static NSString* AddNewMateCellIden = @"AddNewMateCellIden";
		AddNewMateCell* cell = (AddNewMateCell*)[tableView dequeueReusableCellWithIdentifier:AddNewMateCellIden];
		if (!cell) {
			cell = [[[AddNewMateCell alloc] initWithReuseIdentifier:AddNewMateCellIden] autorelease];
		}
		[cell changeTextTo:[NSString stringWithFormat:@"Add General Experience"]];
		return cell;
	}
	
	General* g = (General*)[generals objectAtIndex:indexPath.row];
	static NSString* SocialCellIden = @"SocialCellIden";
	MateCell* cell = (MateCell*)[tableView dequeueReusableCellWithIdentifier:SocialCellIden];
	if (!cell) {
		cell = [[[MateCell alloc] initWithReuseIdentifier:SocialCellIden] autorelease];
	}
	[cell setupWithGeneral:g];
	return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([mate.generals count] > 0 && ![self isAddIndexPath:indexPath]) {
		General* g = [[[Services services] dm].currentMate.generals objectAtIndex:indexPath.row];
		[[Services services] dm].currentGeneral = g;
		[self.navigationController pushViewController:[[[AddNewGeneralForm alloc] initWithGeneral:g] autorelease] animated:YES];
	}
	
	if([self isAddIndexPath:indexPath]){
		[self.navigationController pushViewController:[[[AddNewGeneralForm alloc] initWithMate:mate] autorelease] animated:YES];
	}
	
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self isAddIndexPath:indexPath]){ return 25; }
	return 75;
}

@end