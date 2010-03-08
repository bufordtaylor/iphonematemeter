//
//  matemeterAppDelegate.m
//  matemeter
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "matemeterAppDelegate.h"
#import "MateListVC.h"
#import "Services.h"

@implementation matemeterAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	services = [[Services alloc] init];
	matesVC = [[MateListVC alloc] init];
	nav = [[UINavigationController alloc] initWithRootViewController:matesVC];
	
	
    // Override point for customization after app launch    
    [window addSubview:nav.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [nav release];
    [window release];
	[matesVC release];
    [super dealloc];
}

-(Services*) services {
	return services;
}


@end
