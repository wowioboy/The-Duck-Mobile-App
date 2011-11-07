//
//  RootViewController.h
//  TheDuck
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {

IBOutlet UIButton *newsButton;
IBOutlet UIButton *quackButton;
IBOutlet UIButton *featButton;

}

@property (nonatomic, retain) UIButton *newsbutton;
@property (nonatomic, retain) UIButton *quackButton;
@property (nonatomic, retain) UIButton *featButton;

// Button Action Methods
-(IBAction)getComicNews:(id)sender;
-(IBAction)getQuackcast:(id)sender;
-(IBAction)getFeaturedComics:(id)sender;

@end
