//
//  AddNewExpenseForm.m
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewSocialForm.h"
#import "AddTextCell.h"
#import "AddLargeTextCell.h"
#import "Social.h"
#import "KeyvalCell.h"
#import "AddDateVC.h"
#import "AddRatingVC.h"
#import "AddSegment.h"

#import "ExpenseList.h"
#import "Mate.h"
#import "Services.h"
#import "DataManager.h"

@implementation AddNewSocialForm

-(id) init {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.title = @"Add Social Experience";
		UIBarButtonItem* backBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tapCancel)];
		backBtn.title = @"Cancel";
		self.navigationItem.leftBarButtonItem = backBtn;
		
		//self.tableView.allowsSelection = false;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		self.tableView.scrollEnabled = NO;
		saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tapSave)];
		saveBtn.title = @"Save";
		
		
		doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		doneButton.tag = 99;
		doneButton.frame = CGRectMake(0, 163, 106, 53);
		doneButton.adjustsImageWhenHighlighted = NO;
		[doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"downdown.png"] forState:UIControlStateHighlighted];
		[doneButton addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];
		[doneButton retain];
		
	}
	mate = [[Services services] dm].currentMate;
	return self;
}

-(id) initWithMate:(Mate*) m {
	if (self = [self init]) {
	}
	return self;
}

-(void) showSaveButton {
	if (![social.expand_or_decrease isEqualToString:@"Undecided"] && social.rating <= 10 && ([[social.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)) {
		self.navigationItem.rightBarButtonItem = saveBtn;
	}	
}



-(id) initWithSocial:(Social*) s {
	if(self = [self init]){
		social = [[Services services] dm].currentSocial;
		updateSocial = YES;
	}
	return self;
}

-(void) dealloc {
	[doneButton release];
	[descriptionTextCell release];
	[dateCell release];
	[super dealloc];
}

-(void) tapCancel {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) tapSave {
	[self saveInfo];
	NSLog(@"Social id is %d", social.ID);
	NSLog(@"mateid %d, description %@, date %@, growth %@, rating %d", social.mateID, social.description, [social datestr], social.expand_or_decrease, social.rating);
	if (updateSocial) {
		[[[Services services] dm] updateSocial:social.ID description:social.description start_date:[social datestr] expand_or_decrease:social.expand_or_decrease rating:social.rating latest:0];
	} else {
		
		[[[Services services] dm] insertSocial:social.mateID description:social.description start_date:[social datestr] expand_or_decrease:social.expand_or_decrease rating:social.rating];
	}
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) tapDone {
	if ([[descriptionTextCell txtBox] isFirstResponder]) [[descriptionTextCell txtBox] resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
	[self saveInfo];
	[self showSaveButton];

}


-(void) saveInfo {
	if (!social) {
		[[Services services] dm].currentSocial = [[Social alloc] init];
		social = [[Services services] dm].currentSocial;
		social.date = [NSDate date];
		social.rating = 11;
		social.mateID = mate.ID;
		social.expand_or_decrease = @"Undecided";
	}
	social.description = [descriptionTextCell txtBox].text;
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
			[descriptionTextCell setTheValues:@"Short Description" txtStart:@"Introduced Jim or Won't let me go to Vegas"];
			[descriptionTextCell txtBox].delegate = self;
			[descriptionTextCell txtBox].keyboardType = UIKeyboardTypeAlphabet;
			descriptionTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		if (social) {
			[descriptionTextCell setExistingValue:social.description];
		}
		return descriptionTextCell;
	}
	
	//Cell to get date
	if (indexPath.row == 1 && indexPath.section == 0) {
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
		if (social) {
			NSString *strDate = [formatter stringFromDate:social.date];
			[dateCell setTheValues:@"When did it happen?" valStart:strDate];
		}
		return dateCell;
	}
	
	//Cell to get social growth
	if (indexPath.row == 2 && indexPath.section == 0) {
		static NSString* KeyValCellIden = @"KeyValCellIden";
		circleCell = (KeyvalCell*)[tableView dequeueReusableCellWithIdentifier:KeyValCellIden];
		if (!circleCell) {
			circleCell = [[KeyvalCell alloc] initWithReuseIdentifier:KeyValCellIden];
			[circleCell setTheValues:@"Social Growth" valStart:@"Click to answer"];
		}
		if(social && ![social.expand_or_decrease isEqualToString:@"Undecided"]){
			[circleCell setTheValues:@"Social Growth" valStart:social.expand_or_decrease];
		}
		return circleCell;
	}
	
	//Cell to get rating
	if (indexPath.row == 3 && indexPath.section == 0) {
		static NSString* KeyValCellIden = @"KeyValCellIden";
		ratingCell = (KeyvalCell*)[tableView dequeueReusableCellWithIdentifier:KeyValCellIden];
		if (!ratingCell) {
			ratingCell = [[KeyvalCell alloc] initWithReuseIdentifier:KeyValCellIden];
			[ratingCell setTheValues:@"How satisfied were you?" valStart:@"Click to rate"];
			
			
		}
		if(social && social.rating < 11){
			[ratingCell setTheValues:@"How satisfied were you?" valStart:[NSString stringWithFormat:@"%d", social.rating]];
		}
		return ratingCell;
	}
	
	static NSString* DefaultCellIden = @"DefaultCellIden";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIden];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:DefaultCellIden] autorelease];
	}
	return cell;
	NSLog(@"WE SHOULD NEVER REACH HERE");
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 1) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddDateVC alloc] initWithSocial:social] autorelease] animated:YES];
	} else if (indexPath.row == 2) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddSegment alloc] initWithSocial:social] autorelease] animated:YES];
	} else if (indexPath.row == 3) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddRatingVC alloc] initWithSocial:social] autorelease] animated:YES];
	}
	
}


-(void)viewWillAppear:(BOOL)animated
{
	if (social) {
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



- (void)keyboardWillShow:(NSNotification *)notif
{
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
		for(int i=0; i<[tempWindow.subviews count]; i++) {
			if (doneButton.tag == 99) {
				[doneButton removeFromSuperview];
			}
		}
	[self showDoneButton];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	return YES;
	
}



@end
