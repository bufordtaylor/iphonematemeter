//
//  matemeterAppDelegate.h
//  matemeter
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MateListVC;

@interface matemeterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	UINavigationController* nav;
	MateListVC* matesVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

