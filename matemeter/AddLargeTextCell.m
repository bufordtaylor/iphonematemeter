//
//  AddLargeTextCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/27/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddLargeTextCell.h"


@implementation AddLargeTextCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddLargeText" reuseIdentifier:ri]){
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
	lbl.textAlignment = UITextAlignmentCenter;
	txtBox.placeholder = [NSString stringWithString:txtStart];
}

-(void) setExistingValue:(NSString*)val {
	txtBox.text = val;
}

-(UITextField*) txtBox {
	return txtBox;
}

@end
