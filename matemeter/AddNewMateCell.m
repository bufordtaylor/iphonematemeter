//
//  AddNewMateCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/3/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddNewMateCell.h"


@implementation AddNewMateCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddNewMate" reuseIdentifier:ri]){
		fieldLabel.text = [NSString stringWithString:@"Add Mate ..."];
	}
	return self;
}

-(void) dealloc {	
	[fieldLabel release];
	[super dealloc];
	
}

@end
