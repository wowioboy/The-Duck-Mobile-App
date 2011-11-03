//
//  AppDelegate.h
//  TheDuckWebcomics
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

//@class ASINetworkQueue;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    //ASINetworkQueue *networkQueue;
    
    UINavigationController *navController;
    
    Reachability *hostReach;
    Reachability *internetReach;
    Reachability *wifiReach;
	
	NetworkStatus hostStatus;
	NetworkStatus internetStatus;
	NetworkStatus wifiStatus;

}

@property NetworkStatus hostStatus;
@property NetworkStatus internetStatus;
@property NetworkStatus wifiStatus;

@property (strong, nonatomic) UIWindow *window;

//@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, strong) UINavigationController *navController;

// create a shared delegate
+ (AppDelegate *)sharedAppDelegate;

// reachability method
- (void)updateReachabilityStatus;


@end
