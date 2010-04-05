//
//  KeyvalCell.h
//  matemeter
//
//  Created by Buford Taylor on 3/28/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"


@interface KeyvalCell : IBTableViewCell {
	IBOutlet UILabel* key;
	IBOutlet UILabel* val;
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setTheValues:(NSString*)k valStart:(NSString*)v;
-(void) setExistingValue:(NSString*)v;

@end
