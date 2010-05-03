//
//  ApiManager.h
//  matemeter
//
//  Created by Buford Taylor on 5/1/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@class ServerAdapter;


@interface ApiManager : NSObject {
	
	ServerAdapter* APIAdapter;
	id<ApiManagerUpdateDelegate> activeVC;

}

extern NSString *const ENVIRONMENT;

-(NSString*) errorMessageFromSuccessfulResult:(NSDictionary*)result requireKey:(NSString*)key;
-(void) APIAddProfile:(id<ApiManagerUpdateDelegate>)obj username:(NSString*)un password:(NSString*)pw uid:(NSString*)uid;

@end
