//
//  AddNewMateForm.h
//  matemeter
//
//  Created by Buford Taylor on 3/4/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"

@interface AddNewMateForm : IBTableViewCell {
	IBOutlet UITextField* nameInput;
	IBOutlet UISegmentedControl* sexInput;
	IBOutlet UITextField* ageInput;
	IBOutlet UIPickerView* relationInput;
	IBOutlet UIPickerView* startMonthInput;
	IBOutlet UIPickerView* startYearInput;
}

-(id) initWithReuseIdentifier:(NSString*)ri;

@end
