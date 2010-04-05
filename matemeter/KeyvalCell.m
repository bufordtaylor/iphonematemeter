//
//  KeyvalCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "KeyvalCell.h"


@implementation KeyvalCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"KeyValCell" reuseIdentifier:ri]){
	}
	return self;
}

-(void) dealloc {	
	[key release];
	[val release];
	[super dealloc];
}

-(void) setTheValues:(NSString*)k valStart:(NSString*)v {
	key.text = [NSString stringWithString:k];
	val.text = [NSString stringWithString:v];
	val.textAlignment = UITextAlignmentRight;
}

-(void) setExistingValue:(NSString*)v {
	val.text = v;
}

@end
