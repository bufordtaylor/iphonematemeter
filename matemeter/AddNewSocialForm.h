//
//  AddNewExpenseForm.h
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Social;
@class AddTextCell;
@class AddLargeTextCell;
@class KeyvalCell;
@class Mate;


@interface AddNewSocialForm : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate>  {
	UIBarButtonItem* saveBtn;
	Social* social;
	Mate* mate;
	
	AddTextCell* costTextCell;
	AddLargeTextCell* descriptionTextCell;
	KeyvalCell* dateCell;
	KeyvalCell* ratingCell;
	KeyvalCell* circleCell;
	BOOL updateSocial;
	
	UIButton* doneButton;
}

-(id) initWithSocial:(Social*) s;
-(id) initWithMate:(Mate*) m;
-(void) saveInfo;
-(void) showSaveButton;

@end
