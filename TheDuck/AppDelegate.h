//
//  AppDelegate.h
//  TheDuck
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {

    RootViewController *rootController;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) RootViewController *rootController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
