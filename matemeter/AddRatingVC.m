//
//  AddRatingVC.m
//  matemeter
//
//  Created by Buford Taylor on 4/3/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddRatingVC.h"
#import "Expense.h"
#import "Sex.h"
#import "Social.h"
#import "General.h"
#import "AddRatingCell.h"
#import "AddNewExpenseForm.h"
#import "Services.h"
#import "DataManager.h"

@implementation AddRatingVC


-(id) init {
	if (self = [super init]) {
		updateWho = 0;
		self.title = @"Add Rating";
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


-(id) initWithExpense:(Expense *)e {
	if (self = [super init]) {
		expense = [[Services services] dm].currentExpense;
		self = [self init];
		updateWho = 1;
	}
	return self;
}

-(id) initWithSocial:(Social *)s {
	if (self = [super init]) {
		social = [[Services services] dm].currentSocial;
		self = [self init];
		updateWho = 2;
	}
	return self;
}


-(id) initWithSex:(Sex *)s {
	if (self = [super init]) {
		sex = [[Services services] dm].currentSex;
		self = [self init];
		updateWho = 3;
	}
	return self;
}

-(id) initWithGeneral:(General *)g {
	if (self = [super init]) {
		general = [[Services services] dm].currentGeneral;
		self = [self init];
		updateWho = 4;
	}
	return self;
}


-(void) dealloc {
	[cell release];
	[super dealloc];
}

-(void) tapSave {
	NSLog(@"tapped Save");
	if (expense) {
		expense.rating = sliderValue;
		NSLog(@"EXPENSE description: %@, cost: %d, date: %@,   rating: %d", expense.description, expense.cost, [expense datestr], expense.rating);
	}
	if(social) {
		social.rating = sliderValue;
		NSLog(@"SOCIAL %d, rating %d", social.ID, social.rating);
	}
	
	if(sex) {
		sex.rating = sliderValue;
		NSLog(@"Sex %d, rating %d", sex.ID, sex.rating);
	}
	if(general) {
		general.rating = sliderValue;
		NSLog(@"Sex %d, rating %d", general.ID, general.rating);
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
	
	static NSString* AddRatingCellIden = @"AddRatingCellIden";
	cell = (AddRatingCell*)[tableView dequeueReusableCellWithIdentifier:AddRatingCellIden];
	if (!cell) {
		cell = [[AddRatingCell alloc] initWithReuseIdentifier:AddRatingCellIden];
		[[cell rating] addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
	}
	switch (updateWho) {
		case 1: //Expense
			if(expense.rating <= 10){
				sliderValue = expense.rating;
			} else {
				sliderValue = 5;
			}
			break;
		case 2: //Social
			if(social.rating <= 10){
				sliderValue = social.rating;
			} else {
				sliderValue = 5;
			}
			break;
		case 3: //Sex
			if(sex.rating <= 10){
				sliderValue = sex.rating;
			} else {
				sliderValue = 5;
			}
			break;
		case 4: //General
			if(general.rating <= 10){
				sliderValue = general.rating;
			} else {
				sliderValue = 5;
			}
			break;
		case 0: //new rating
		default:
			sliderValue = 5;
			break;
	}
	
	NSLog(@"slidervalue is %d", sliderValue);
	[cell lbl].text = [NSString stringWithFormat:@"%d", sliderValue];
	[cell rating].value = sliderValue;
	return cell;
}

- (void)sliderAction:(UISlider*)sender {
	[cell lbl].text = [NSString stringWithFormat:@"%.0f", [sender value]];
	sliderValue = (int)([sender value] + 0.5f);
	switch ((int)[sender value]) {
		case 0:
			[cell lbl].textColor = [UIColor redColor];
			break;
		case 1:
			[cell lbl].textColor = [UIColor redColor];
			break;
		case 2:
			[cell lbl].textColor = [UIColor magentaColor];
			break;
		case 3:
			[cell lbl].textColor = [UIColor magentaColor];
			break;		
		case 4:
			[cell lbl].textColor = [UIColor orangeColor];
			break;
		case 5:
			[cell lbl].textColor = [UIColor orangeColor];
			break;
		case 6:
			[cell lbl].textColor = [UIColor brownColor];
			break;
		case 7:
			[cell lbl].textColor = [UIColor brownColor];
			break;
		case 8:
			[cell lbl].textColor = [UIColor greenColor];
			break;
		case 9:
			[cell lbl].textColor = [UIColor greenColor];
			break;
		case 10:
			[cell lbl].textColor = [UIColor blueColor];
			break;
		default:
			break;
	}

}

@end
