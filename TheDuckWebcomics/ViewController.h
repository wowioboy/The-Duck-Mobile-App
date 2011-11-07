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
    NSMutableData *newsData;
    NSMutableData *featData;
    NSMutableData *quackData;

    
    IBOutlet UIButton *newsButton;
    IBOutlet UIButton *featButton;
    IBOutlet UIButton *quackButton;
    
    NSURLConnection *newsConn;
    NSURLConnection *featConn;
    NSURLConnection *quackConn;
}

-(IBAction)getNews:(id)sender;
-(IBAction)getFeatures:(id)sender;
-(IBAction)getEpisodes:(id)sender;
-(NSString*)fetchRemoteData:(NSString *)dataStr;

-(NSString *)stringWithUrl:(NSURL *)url;
-(id) objectWithUrl:(NSURL *)url orError:(NSError *)err;
-(NSDictionary *)downloadDuckFeed:(NSURL *)url;

@property (nonatomic, retain) UIButton *newsButton;
@property (nonatomic, retain) UIButton *featButton;
@property (nonatomic, retain) UIButton *quackButton;

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableData *newsData;
@property (strong, nonatomic) NSMutableData *featData;
@property (strong, nonatomic) NSMutableData *quackData;
@property (strong, nonatomic) ListController *listController;

@property (strong, nonatomic) NSURLConnection *newsConn;
@property (strong, nonatomic) NSURLConnection *featConn;
@property (strong, nonatomic) NSURLConnection *quackConn;

@end
