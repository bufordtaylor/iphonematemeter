//
//  AddSegmentCell.m
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddSegmentCell.h"


@implementation AddSegmentCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"AddSegment" reuseIdentifier:ri]){
		lbl.textAlignment = UITextAlignmentCenter;
	}
	return self;
}

-(void) dealloc {
	[segment release];
	[lbl release];
	[super dealloc];
}

-(void) setupSegment:(int)i {
	segment.selectedSegmentIndex = i;
//	rating.value = [r intValue];
//	lbl.text = defaultLbl;
}

-(UISegmentedControl*) segment {
	return segment;
}

-(UILabel*) lbl {
	return lbl;
}

@end