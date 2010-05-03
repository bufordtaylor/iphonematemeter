//
//  Protocols.h
//  eventbrite
//
//  Created by Buford Taylor on 5/2/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

@protocol ApiManagerUpdateDelegate
-(void) success;
-(void) failure:(NSString*)msg;
@end