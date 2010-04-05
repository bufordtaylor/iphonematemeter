//
//  AddRatingCell.h
//  matemeter
//
//  Created by Buford Taylor on 4/2/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTableViewCell.h"


@interface AddRatingCell : IBTableViewCell {
	IBOutlet UILabel* lbl;
	IBOutlet UISlider* rating;
	
}

-(id) initWithReuseIdentifier:(NSString*)ri;
-(void) setup:(NSString*)defaultLbl rating:(UISlider*) r;
-(UILabel*) lbl;
-(UISlider*) rating;

@end
