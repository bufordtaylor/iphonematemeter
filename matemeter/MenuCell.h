//
//  MenuCell.h
//  matemeter
//
//  Created by Buford Taylor on 3/15/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"

@class Mate;

@interface MenuCell : IBTableViewCell {
	IBOutlet UILabel* menuTitle;
	IBOutlet UILabel* menuSubtitle;
	IBOutlet UIImageView* menuImage;
	
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setupWithCategory:(Mate*)m forIndexPath:(NSIndexPath*)indexPath;
-(UIImageView*) menuImage;



@end
