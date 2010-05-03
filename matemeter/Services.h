//
//  Services.h
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataManager;
@class ApiManager;


@interface Services : NSObject {
	DataManager* dm;
	ApiManager* am;
}

+(Services*) services;

-(DataManager*) dm;
-(ApiManager*) am;

@end
