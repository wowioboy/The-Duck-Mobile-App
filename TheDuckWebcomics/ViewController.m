//
//  ViewController.m
//  TheDuckWebcomics
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import "ViewController.h"
#import "ListController.h"

@implementation ViewController

@synthesize newsButton, featButton, quackButton;
@synthesize listController;


-(IBAction)getNews:(id)sender{
    //[self alertWithMessage:@"Get News Here!" withTitle:@"The Duck"];
    listController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	[self.navigationController pushViewController:listController animated:YES];
    [listController setTitle:@"Latest News"];
    
}

-(IBAction)getFeatures:(id)sender{
    //[self alertWithMessage:@"Get Featured Comics Here!" withTitle:@"The Duck"];
    listController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	[self.navigationController pushViewController:listController animated:YES];
    [listController setTitle:@"Featured Comics"];
}

-(IBAction)getEpisodes:(id)sender{
    //[self alertWithMessage:@"Get Quackcast Episodes Here!" withTitle:@"The Duck"];
    listController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	[self.navigationController pushViewController:listController animated:YES];
    [listController setTitle:@"Quackcast Episodes"];
}

-(NSString*)fetchRemoteData:(NSString *)dataStr {
    
    
    return @"";
}

#pragma mark -
#pragma mark Alert Message Method

- (void)alertWithMessage:(NSString *)msg withTitle:(NSString *)title 
{
	
	if ([title length] == 0)
		title = @"Error";
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
													message:msg
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles: nil];
	[alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:TRUE];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
