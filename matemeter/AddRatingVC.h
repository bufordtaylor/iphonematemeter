//
//  AddRatingVC.h
//  matemeter
//
//  Created by Buford Taylor on 4/3/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Expense;
@class AddRatingCell;

@interface AddRatingVC : UITableViewController {
	int sliderValue;
	Expense* expense;
	AddRatingCell* cell;
	
}
	
-(id) initWithExpense:(Expense*)e;

@end
