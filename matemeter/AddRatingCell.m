//
//  AddRatingCell.m
//  matemeter
//
//  Created by Buford Taylor on 4/2/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddRatingCell.h"


@implementation AddRatingCell


-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddRating" reuseIdentifier:ri]){
		lbl.textAlignment = UITextAlignmentCenter;
				
		rating.minimumValue = 0.0;
		rating.maximumValue = 10.0;
		rating.tag = 1;
		rating.value =  5.0;
		rating.continuous = YES;
	}
	return self;
}

-(void) dealloc {
	[rating release];
	[lbl release];
	[super dealloc];
}

-(void) setup:(NSString*)defaultLbl rating:(NSDecimalNumber*) r {
	rating.value = [r intValue];
	lbl.text = defaultLbl;
}

-(UISlider*) rating {
	return rating;
}

-(UILabel*) lbl {
	return lbl;
}

@end