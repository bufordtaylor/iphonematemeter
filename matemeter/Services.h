//
//  Services.h
//  matemeter
//
//  Created by Buford Taylor on 3/7/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataManager;


@interface Services : NSObject {
	DataManager* dm;
}

+(Services*) services;

-(DataManager*) dm;

@end
