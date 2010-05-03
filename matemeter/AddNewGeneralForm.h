//
//  AddNewGeneralForm.h
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class General;
@class AddTextCell;
@class AddLargeTextCell;
@class KeyvalCell;
@class Mate;


@interface AddNewGeneralForm : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate>  {
	UIBarButtonItem* saveBtn;
	General* general;
	Mate* mate;
	
	AddTextCell* costTextCell;
	AddLargeTextCell* descriptionTextCell;
	KeyvalCell* dateCell;
	KeyvalCell* ratingCell;
	BOOL updateGeneral;
	
	UIButton* doneButton;
}

-(id) initWithMate:(Mate*) m;
-(id) initWithGeneral:(General*) g;
-(void) saveInfo;
-(void) showSaveButton;

@end
