//
//  MateListVC.m
//  eventbrite
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MateListVC.h"


@implementation MateListVC

-(id) init {
	if (self = [super init]) {
		self.title = @"Current Mates";
		UIBarButtonItem* addNewBtn = [[[UIBarButtonItem alloc] init] autorelease];
		addNewBtn.title = @"Add Mate";
		self.navigationItem.rightBarButtonItem = addNewBtn;
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(void) viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
}

@end
