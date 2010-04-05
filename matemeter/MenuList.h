//
//  MenuList.h
//  matemeter
//
//  Created by Buford Taylor on 3/15/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Mate;


@interface MenuList : UITableViewController {
	Mate* mate;

}

-(id) initWithMate:(Mate*)m;

@end
