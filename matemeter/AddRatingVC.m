//
//  AddRatingVC.m
//  matemeter
//
//  Created by Buford Taylor on 4/3/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddRatingVC.h"
#import "Expense.h"
#import "AddRatingCell.h"
#import "AddNewExpenseForm.h"


@implementation AddRatingVC



-(id) initWithExpense:(Expense *)e {
	if (self = [super init]) {
		expense = [e retain];
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

-(void) dealloc {
	[expense release];
	[cell release];
	[super dealloc];
}

-(void) tapSave {
	if (expense) {
		expense.rating = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:sliderValue] decimalValue]];
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
	if([expense.rating intValue] <= 10){
		sliderValue = [expense.rating intValue];
	} else {
		sliderValue = 5;
	}	
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
