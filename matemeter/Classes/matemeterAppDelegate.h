//
//  matemeterAppDelegate.h
//  matemeter
//
//  Created by Buford Taylor on 3/2/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class matemeterViewController;

@interface matemeterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    matemeterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet matemeterViewController *viewController;

@end

