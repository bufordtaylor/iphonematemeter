//
//  AddRatingVC.h
//  matemeter
//
//  Created by Buford Taylor on 4/3/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Expense;
@class Sex;
@class Social;
@class AddRatingCell;
@class General;

@interface AddRatingVC : UITableViewController {
	int sliderValue;
	Expense* expense;
	Social* social;
	Sex* sex;
	General* general;
	AddRatingCell* cell;
	
	int updateWho;
	
}
	
-(id) initWithExpense:(Expense*)e;
-(id) initWithSocial:(Social*)s;
-(id) initWithSex:(Sex*)s;
-(id) initWithGeneral:(General*)g;

@end
