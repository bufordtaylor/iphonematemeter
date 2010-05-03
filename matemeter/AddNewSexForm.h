//
//  AddNewSexForm.h
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sex;
@class AddTextCell;
@class AddLargeTextCell;
@class KeyvalCell;
@class Mate;


@interface AddNewSexForm : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate>  {
	UIBarButtonItem* saveBtn;
	Sex* sex;
	Mate* mate;
	
	AddTextCell* costTextCell;
	AddLargeTextCell* descriptionTextCell;
	KeyvalCell* dateCell;
	KeyvalCell* ratingCell;
	BOOL updateSex;
	
	UIButton* doneButton;
}

-(id) initWithMate:(Mate*) m;
-(id) initWithSex:(Sex*) s;
-(void) saveInfo;
-(void) showSaveButton;

@end
