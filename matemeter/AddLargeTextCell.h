//
//  AddLargeTextCell.h
//  matemeter
//
//  Created by Buford Taylor on 3/27/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"

@interface AddLargeTextCell : IBTableViewCell {
	IBOutlet UILabel* lbl;
	IBOutlet UITextField* txtBox;
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setTheValues:(NSString*)lbl txtStart:(NSString*)txtStart;
-(void) setExistingValue:(NSString*)val;
-(UITextField*) txtBox;

@end
