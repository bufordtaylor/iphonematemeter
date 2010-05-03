//
//  AddSegmentCell.h
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"


@interface AddSegmentCell : IBTableViewCell {
	IBOutlet UILabel* lbl;
	IBOutlet UISegmentedControl* segment;
	
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setupSegment:(int)i;
-(UILabel*) lbl;
-(UISegmentedControl*) segment;

@end
