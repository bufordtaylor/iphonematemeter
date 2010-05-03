//
//  AddSegment.m
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddSegment.h"
#import "AddSegmentCell.h"
#import "Social.h"
#import "Services.h"
#import "DataManager.h"

@implementation AddSegment

@synthesize choice;

-(id) init {
	if (self = [super init]) {
		updateWho = 0;
		self.title = @"Add Detail";
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

-(id) initWithSocial:(Social *)s {
	if (self = [super init]) {
		social = [[Services services] dm].currentSocial;
		self = [self init];
		updateWho = 2;
		self.title = @"Add Social Detail";
	}
	return self;
}

-(void) dealloc {
	[cell release];
	[super dealloc];
}

-(void) tapSave {
	NSLog(@"tapped Save");
	if(social) {
		if ([choice isEqualToString:@"Undecided"]) {
			choice = @"Increased";
		}
		social.expand_or_decrease = choice;
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
	
	static NSString* AddCellIden = @"AddCellIden";
	cell = (AddSegmentCell*)[tableView dequeueReusableCellWithIdentifier:AddCellIden];
	if (!cell) {
		cell = [[AddSegmentCell alloc] initWithReuseIdentifier:AddCellIden];
		[[cell segment] addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	}
	switch (updateWho) {
		case 1: 
			break;
		case 2: //Social
			choice = social.expand_or_decrease;
			break;
		case 0: //new rating
		default:
			choice = @"Increased";
			break;
	}

	int i = 0;
	if([choice isEqualToString:@"Decreased"]){
		i = 1;
	}
	[cell setupSegment:i];
	return cell;
}

-(void) segmentAction:(UISegmentedControl*)sender {
	UISegmentedControl* segmentedControl = (UISegmentedControl*) sender;
	choice = (NSString*)[segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
}

@end
