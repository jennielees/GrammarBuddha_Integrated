//
//  AppDelegate.h
//  GrammarBuddha
//
//  Created by Emmy Chen on 2/26/12.
//  Copyright Kuaitech 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
