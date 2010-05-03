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
@class Social;
@class Sex;
@class General;

@interface AddDateVC : UITableViewController <UIPickerViewDelegate> {
	
	Social* social;
	Expense* expense;
	Sex* sex;
	General* general;
	AddDateCell* cell;

}

-(id) initWithExpense:(Expense*)e;
-(id) initWithSocial:(Social*)s;
-(id) initWithSex:(Sex*)s;
-(id) initWithGeneral:(General*)g;


@end
