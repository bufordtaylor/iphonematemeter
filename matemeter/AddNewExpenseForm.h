//
//  AddNewExpenseForm.h
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Expense;
@class AddTextCell;
@class AddLargeTextCell;
@class KeyvalCell;
@class Mate;


@interface AddNewExpenseForm : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate>  {
	UIBarButtonItem* saveBtn;
	Expense* expense;
	Mate* mate;
	
	AddTextCell* costTextCell;
	AddLargeTextCell* descriptionTextCell;
	KeyvalCell* dateCell;
	KeyvalCell* ratingCell;
	BOOL updateExpense;
	
	UIButton* doneButton;
}

-(id) initWithExpense:(Expense*) ex;
-(id) initWithMate:(Mate*) m;
-(void) saveInfo;
-(void) showSaveButton;

@end
