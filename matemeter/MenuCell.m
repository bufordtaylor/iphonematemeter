//
//  MenuCell.m
//  matemeter
//
//  Created by Buford Taylor on 3/15/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "MenuCell.h"
#import "Mate.h"
#import "BucketedHash.h"
#import "Category.h"


@implementation MenuCell

-(id) initWithReuseIdentifier:(NSString *)ri {
	if (self = [super initWithCellNib:@"MenuCell" reuseIdentifier:ri]){
	}
	return self;
}

-(void) dealloc {	
	[menuTitle release];
	[menuSubtitle release];
	[menuImage release];
	[super dealloc];
}

-(void) setupWithCategory:(Mate*)m forIndexPath:(NSIndexPath*)indexPath {
	
	NSString* categoryTitle = (NSString*)[[[m.category categoryNames]  keys] objectAtIndex:indexPath.row];
	NSString* subtitle = (NSString*)[[[m.category categoryNames]  elementsForKey:categoryTitle] objectAtIndex:0];
	NSLog(@"%@", subtitle);
	
	menuTitle.text = categoryTitle;
	menuSubtitle.text = subtitle;
}

@end
