//
//  ViewController.h
//  TheDuckWebcomics
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class ListController;

@interface ViewController : UIViewController{
    
    AppDelegate *appDelegate;
    NSMutableData *receivedData;
    
    IBOutlet UIButton *newsButton;
    IBOutlet UIButton *featButton;
    IBOutlet UIButton *quackButton;
}

-(IBAction)getNews:(id)sender;
-(IBAction)getFeatures:(id)sender;
-(IBAction)getEpisodes:(id)sender;
-(NSString*)fetchRemoteData:(NSString *)dataStr;

@property (nonatomic, retain) UIButton *newsButton;
@property (nonatomic, retain) UIButton *featButton;
@property (nonatomic, retain) UIButton *quackButton;

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) ListController *listController;

@end
