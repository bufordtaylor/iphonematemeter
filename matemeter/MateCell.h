//
//  MateCell.h
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"

@class Mate;
@class Expense;
@class Social;
@class Sex;
@class General;

@interface MateCell : IBTableViewCell {
	IBOutlet UILabel* mateName;
	IBOutlet UILabel* mateDate;
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setupWithMate:(Mate*)m;
-(void) setupWithExpense:(Expense*)ex;
-(void) setupWithSocial:(Social*)s;
-(void) setupWithSex:(Sex*)s;
-(void) setupWithGeneral:(General*)g;

@end
