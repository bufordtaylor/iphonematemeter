//
//  AddNewMateForm.h
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddNewMateForm : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField* nameInput;
	IBOutlet UISegmentedControl* sexInput;
	IBOutlet UITextField* ageInput;
	IBOutlet UISlider* relationInput;
	IBOutlet UIDatePicker* dateInput;
	IBOutlet UILabel* relationLabel;
	
	UIAlertView* dataFailurePopup;
	IBOutlet UIBarButtonItem* rightButton;
	UIButton* doneButton;
}

- (IBAction)cancelInsert;
- (IBAction)completeInsert;

-(id) initWithReuseIdentifier:(NSString*)ri;

-(UITextField*) nameInput;
-(UITextField*) ageInput;
-(UISegmentedControl*) sexInput;
-(UISlider*) relationInput;
-(UIDatePicker*) dateInput;
-(UILabel*) relationLabel;
@end
