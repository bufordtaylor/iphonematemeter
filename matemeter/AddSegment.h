//
//  AddSegment.h
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Social;
@class AddSegmentCell;

@interface AddSegment: UITableViewController {
	Social* social;
	AddSegmentCell* cell;
	
	NSString* choice;
	
	int updateWho;
	
}


@property (nonatomic, retain) NSString* choice;

-(id) initWithSocial:(Social*)s;

@end
