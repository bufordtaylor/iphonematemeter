//
//  AddNewMateCell.h
//  matemeter
//
//  Created by Buford Taylor on 3/3/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"

@interface AddNewMateCell : IBTableViewCell {
	IBOutlet UILabel* fieldLabel;
}

-(id) initWithReuseIdentifier:(NSString*)ri;

@end
