//
//  AddNewGeneralForm.m
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewGeneralForm.h"
#import "AddTextCell.h"
#import "AddLargeTextCell.h"
#import "Social.h"
#import "KeyvalCell.h"
#import "AddDateVC.h"
#import "AddRatingVC.h"
#import "AddSegment.h"
#import "Sex.h"
#import "General.h"
#import "ExpenseList.h"
#import "Mate.h"
#import "Services.h"
#import "DataManager.h"

@implementation AddNewGeneralForm

-(id) init {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.title = @"Add General Experience";
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
	if (general.rating <= 10 && ([[general.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)) {
		self.navigationItem.rightBarButtonItem = saveBtn;
	}	
}



-(id) initWithGeneral:(General*) g {
	if(self = [self init]){
		general = [[Services services] dm].currentGeneral;
		updateGeneral = YES;
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
	NSLog(@"general id is %d", general.ID);
	NSLog(@"mateid %d, description %@, date %@,  rating %d", general.mateID, general.description, [general datestr], general.rating);
	if (updateGeneral) {
		[[[Services services] dm] updateGeneral:general.ID description:general.description start_date:[general datestr] rating:general.rating latest:0];
	} else {
		[[[Services services] dm] insertGeneral:general.mateID description:general.description start_date:[general datestr] rating:general.rating];
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
	if (!general) {
		[[Services services] dm].currentGeneral = [[General alloc] init];
		general = [[Services services] dm].currentGeneral;
		general.date = [NSDate date];
		general.rating = 11;
		general.mateID = mate.ID;
	}
	general.description = [descriptionTextCell txtBox].text;
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
	return 3;
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
			[descriptionTextCell setTheValues:@"Short Description" txtStart:@"Randomly bought me flowers or Really pissed me off"];
			[descriptionTextCell txtBox].delegate = self;
			[descriptionTextCell txtBox].keyboardType = UIKeyboardTypeAlphabet;
			descriptionTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		if (general) {
			[descriptionTextCell setExistingValue:general.description];
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
		if (general) {
			NSString *strDate = [formatter stringFromDate:general.date];
			[dateCell setTheValues:@"When did it happen?" valStart:strDate];
		}
		return dateCell;
	}
	
	//Cell to get rating
	if (indexPath.row == 2 && indexPath.section == 0) {
		static NSString* KeyValCellIden = @"KeyValCellIden";
		ratingCell = (KeyvalCell*)[tableView dequeueReusableCellWithIdentifier:KeyValCellIden];
		if (!ratingCell) {
			ratingCell = [[KeyvalCell alloc] initWithReuseIdentifier:KeyValCellIden];
			[ratingCell setTheValues:@"How satisfied were you?" valStart:@"Click to rate"];
			
			
		}
		if(general && general.rating < 11){
			[ratingCell setTheValues:@"How satisfied were you?" valStart:[NSString stringWithFormat:@"%d", general.rating]];
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
		[self.navigationController pushViewController:[[[AddDateVC alloc] initWithGeneral:general] autorelease] animated:YES];
	}  else if (indexPath.row == 2) {
		[self saveInfo];
		[self.navigationController pushViewController:[[[AddRatingVC alloc] initWithGeneral:general] autorelease] animated:YES];
	}
	
}


-(void)viewWillAppear:(BOOL)animated
{
	if (general) {
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
