//
//  AddDateCell.h
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"


@interface AddDateCell : IBTableViewCell {
	IBOutlet UILabel* lbl;
	IBOutlet UIDatePicker* datepicker;
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setup:(NSString*)defaultLbl date:(NSDate*) date;
-(UILabel*) lbl;
-(UIDatePicker*) datepicker;

@end
