//
//  AppDelegate.m
//  TheDuckWebcomics
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Reachability.h"
//#import "ASINetworkQueue.h"
//#import "ASIHTTPRequest.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navController;
@synthesize hostStatus, internetStatus, wifiStatus;

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
	// Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called. 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
	
    // check what type of internet connection we have
	hostReach = [Reachability reachabilityWithHostName:homeURL];
	[hostReach startNotifier];
	
    internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	
    wifiReach = [Reachability reachabilityForLocalWiFi];
	[wifiReach startNotifier];
	
	// update network reachability
	[self updateReachabilityStatus];
    
    
    // stuff everything onto the main stage
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
   	navController = [[UINavigationController alloc] init];
    navController.navigationBarHidden = YES;
	[navController.view setAutoresizesSubviews:YES];
    [navController pushViewController:self.viewController animated:NO];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}



#pragma mark -
#pragma mark Reachability Methods

- (void)updateReachabilityStatus
{
	hostStatus = [hostReach currentReachabilityStatus];
	wifiStatus = [wifiReach currentReachabilityStatus];
	internetStatus = [internetReach currentReachabilityStatus];
	
	if (hostStatus == NotReachable && internetStatus == NotReachable && wifiStatus == NotReachable) {
		
		// alert the user that there is no internet connectivity
		NSString *errorString = @"There is Currently NO Internet Connectivity.\nYou will be unable to play iMogul effectively\nuntil connectivity has been restored.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
														message:errorString
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles: nil];
		[alert show];
		
	}
}

// Called by Reachability whenever status changes.
- (void)reachabilityChanged:(NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	
	if(curReach == hostReach)
		hostStatus = [curReach currentReachabilityStatus];
	else if (curReach == wifiReach)
		wifiStatus = [curReach currentReachabilityStatus];
	else if (curReach == internetReach)
		internetStatus = [curReach currentReachabilityStatus];
	
	[self updateReachabilityStatus];
}

@end
