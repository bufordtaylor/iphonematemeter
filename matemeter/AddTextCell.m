//
//  AddTextCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/21/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddTextCell.h"


@implementation AddTextCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddText" reuseIdentifier:ri]){
	}
	return self;
}

-(void) dealloc {	
	[lbl release];
	[txtBox release];
	[super dealloc];
}

-(void) setTheValues:(NSString*)lbltext txtStart:(NSString*)txtStart {
	lbl.text = [NSString stringWithString:lbltext];
	txtBox.placeholder = [NSString stringWithString:txtStart];
}

-(void) setExistingValue:(NSString*)val {
	txtBox.text = val;
}

-(UITextField*) txtBox {
	return txtBox;
}

@end
