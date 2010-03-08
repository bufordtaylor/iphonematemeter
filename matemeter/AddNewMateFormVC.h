//
//  AddNewMateFormVC.h
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddNewMateForm.h";

@interface AddNewMateFormVC : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate>  {
	AddNewMateForm* mateForm;
	UIBarButtonItem* saveBtn;
}

-(void)setViewMovedUp:(BOOL)movedUp;

@end
