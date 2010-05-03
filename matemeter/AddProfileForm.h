//
//  AddProfileForm.h
//  matemeter
//
//  Created by Buford Taylor on 5/1/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "LoadingView.h"


@interface AddProfileForm : UIViewController <UITextFieldDelegate, ApiManagerUpdateDelegate> {
	IBOutlet UITextField* nameInput;
	IBOutlet UITextField* pwInput;
	
	LoadingView* loadingView;
	

	UIAlertView* dataFailurePopup;
	IBOutlet UIBarButtonItem* rightButton;
	UIButton* doneButton;
}

- (IBAction)cancelInsert;
- (IBAction)completeInsert;

@end