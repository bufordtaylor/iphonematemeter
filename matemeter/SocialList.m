//
//  SocialList.m
//  matemeter
//
//  Created by Buford Taylor on 4/22/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "SocialList.h"
#import "Mate.h"
#import "AddNewMateCell.h"
#import "AddNewExpenseForm.h"
#import "AddNewSocialForm.h"
#import "MenuList.h"
#import "MateCell.h"
#import "Services.h"
#import "DataManager.h"


@implementation SocialList

-(id) initWithMate:(Mate *)m {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		mate = [[Services services] dm].currentMate;
		self.title = @"Social Circle";
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
	[[[Services services] dm] populateSocialsFromMateID:mate.ID];
	[[Services services] dm].currentSocial = nil;
	[self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 1) {
		return 1;
	}
	return [mate.socials count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSMutableArray* socials = mate.socials;
	
	if([self isAddIndexPath:indexPath]){
		static NSString* AddNewMateCellIden = @"AddNewMateCellIden";
		AddNewMateCell* cell = (AddNewMateCell*)[tableView dequeueReusableCellWithIdentifier:AddNewMateCellIden];
		if (!cell) {
			cell = [[[AddNewMateCell alloc] initWithReuseIdentifier:AddNewMateCellIden] autorelease];
		}
		[cell changeTextTo:[NSString stringWithFormat:@"Add Social Experience"]];
		return cell;
	}
	
	Social* s = (Social*)[socials objectAtIndex:indexPath.row];
	static NSString* SocialCellIden = @"SocialCellIden";
	MateCell* cell = (MateCell*)[tableView dequeueReusableCellWithIdentifier:SocialCellIden];
	if (!cell) {
		cell = [[[MateCell alloc] initWithReuseIdentifier:SocialCellIden] autorelease];
	}
	[cell setupWithSocial:s];
	return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([mate.socials count] > 0 && ![self isAddIndexPath:indexPath]) {
		Social* social = [[[Services services] dm].currentMate.socials objectAtIndex:indexPath.row];
		[[Services services] dm].currentSocial = social;
		[self.navigationController pushViewController:[[[AddNewSocialForm alloc] initWithSocial:social] autorelease] animated:YES];
	}
	
	if([self isAddIndexPath:indexPath]){
		[self.navigationController pushViewController:[[[AddNewSocialForm alloc] initWithMate:mate] autorelease] animated:YES];
	}
	
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self isAddIndexPath:indexPath]){ return 25; }
	return 75;
}

@end