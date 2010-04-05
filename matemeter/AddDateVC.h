//
//  AddDateVC.h
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Expense;
@class AddDateCell;

@interface AddDateVC : UITableViewController <UIPickerViewDelegate> {
	
	Expense* expense;
	AddDateCell* cell;

}

-(id) initWithExpense:(Expense*)e;

@end
