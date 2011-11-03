//
//  AppDelegate.h
//  TheDuckWebcomics
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

//@class ASINetworkQueue;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    //ASINetworkQueue *networkQueue;
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    UINavigationController *navController;
    
    Reachability *hostReach;
    Reachability *internetReach;
    Reachability *wifiReach;
	
	NetworkStatus hostStatus;
	NetworkStatus internetStatus;
	NetworkStatus wifiStatus;

}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property NetworkStatus hostStatus;
@property NetworkStatus internetStatus;
@property NetworkStatus wifiStatus;

@property (strong, nonatomic) UIWindow *window;

//@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, strong) UINavigationController *navController;

// create a shared delegate
+(AppDelegate *)sharedAppDelegate;

-(NSString *)applicationDocumentsDirectory;
-(NSString *)userProfilePath;

-(void)alertWithMessage:(NSString *)msg withTitle:(NSString *)title;

// reachability methods
-(BOOL)internetCheck;
-(void)updateReachabilityStatus;


@end
