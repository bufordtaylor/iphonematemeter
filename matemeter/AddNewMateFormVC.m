//
//  AddNewMateFormVC.m
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewMateFormVC.h"
#import "AddNewMateForm.h"


@implementation AddNewMateFormVC

-(id) init {
	if (self = [super init]) {
		self.title = @"Basic Info";
		UIBarButtonItem* backBtn = [[[UIBarButtonItem alloc] init] autorelease];
		backBtn.title = @"Cancel";
		self.navigationItem.backBarButtonItem = backBtn;
	}
	return self;
}

-(void) dealloc {
	[super dealloc];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString* AddNewMateFormIden = @"AddNewMateFormIden";
	AddNewMateForm* cell = (AddNewMateForm*)[tableView dequeueReusableCellWithIdentifier:AddNewMateFormIden];
	if (!cell) {
		cell = [[[AddNewMateForm alloc] initWithReuseIdentifier:AddNewMateFormIden] autorelease];
	}
	return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 300;
}


@end
