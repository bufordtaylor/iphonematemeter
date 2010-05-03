//
//  SexList.h
//  matemeter
//
//  Created by Buford Taylor on 4/25/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Mate;


@interface SexList : UITableViewController {
	Mate* mate;
	
}

-(id) initWithMate:(Mate*)m;
-(BOOL) isAddIndexPath:(NSIndexPath*)indexPath;

@end
