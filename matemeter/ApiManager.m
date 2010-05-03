//
//  ApiManager.m
//  matemeter
//
//  Created by Buford Taylor on 5/1/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "ApiManager.h"
#import "ServerAdapter.h"
#import "Services.h"
#import "Settings.h"
#import "DataManager.h"


@implementation ApiManager

NSString *const ENVIRONMENT = @"www.imawesomer";

-(void) dealloc{
	[APIAdapter release];
	[super dealloc];
}

-(NSString*) errorMessageFromSuccessfulResult:(NSDictionary*)result requireKey:(NSString*)key  {
	NSDictionary* errorMaybe = (NSDictionary*)[result objectForKey:@"error"];
	if (errorMaybe && ![result objectForKey:key]) {
		NSString* errorMsg = [errorMaybe objectForKey:@"error_message"];
		if (!errorMsg) { errorMsg = @"Unable to get your events at this time."; }
		NSLog(@"Error message %@", errorMsg);
		return errorMsg;
	}	
	return nil;
}


-(void) APIAddProfile:(id<ApiManagerUpdateDelegate>)obj username:(NSString*)un password:(NSString*)pw uid:(NSString*)uid {
	activeVC = obj;
	if (!APIAdapter) {
		APIAdapter = [[ServerAdapter alloc] initWithCallbackObj:self 
														 successMeth:@selector(APIAddProfileSuccess:) 
														 failureMeth:@selector(APIGeneralFailure:)];
	}
	NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
							EB_APP_KEY, @"k",
							un, @"e",
							pw, @"p",
							uid, @"u",
							nil];
	[APIAdapter call:@"user.php" params:params];
}

-(void) APIAddProfileSuccess:(NSDictionary*)result {
	NSString* errorMaybe = [self errorMessageFromSuccessfulResult:result requireKey:@"user"];
	if (errorMaybe) {
		NSLog(@"errorMaybe %@", errorMaybe);
		[activeVC failure:errorMaybe];
		return;
	}
	//NSDictionary* dict = (NSDictionary*)[result objectForKey:@"user"];
	
	NSArray* rawEvents = (NSArray*)[result objectForKey:@"user"];
	NSDictionary* topLevel = (NSDictionary*)[rawEvents objectAtIndex:0];
	
	NSString* uid = (NSString*)[topLevel objectForKey:@"id"];
	[[[Services services] dm] storeUserId:uid];

	[activeVC success];
}

-(void) APIGeneralFailure:(NSString*)msg {
	NSLog(@"Failed %@", msg);
	[activeVC failure:msg];
}

@end
