//
//  ViewController.m
//  TheDuckWebcomics
//
//  Created by Lawrence Leach on 11/2/11.
//  Copyright (c) 2011 Alliance Acquisitions, Inc. All rights reserved.
//

#import "ViewController.h"
#import "ListController.h"
#import "SBJson.h"

@implementation ViewController

@synthesize newsButton, featButton, quackButton;
@synthesize listController, appDelegate;
@synthesize newsConn, featConn, quackConn, newsData, featData, quackData;


-(IBAction)getNews:(id)sender{
    
    // setup data request
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:newsURL]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];

    // fire up the connection
    newsConn=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (newsConn)
        newsData = [NSMutableData data];
    else
        [self.appDelegate alertWithMessage:@"Connection Failed" withTitle:@"Error!"];
    
        
    listController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	[self.navigationController pushViewController:listController animated:YES];
    [listController setTitle:@"Latest News"];
    
}

-(IBAction)getFeatures:(id)sender{
    //[self.appDelegate alertWithMessage:@"Get Featured Comics Here!" withTitle:@"The Duck"];
    listController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	[self.navigationController pushViewController:listController animated:YES];
    [listController setTitle:@"Featured Comics"];
}

-(IBAction)getEpisodes:(id)sender{
    //[self.appDelegate alertWithMessage:@"Get Quackcast Episodes Here!" withTitle:@"The Duck"];
    listController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
	[self.navigationController pushViewController:listController animated:YES];
    [listController setTitle:@"Quackcast Episodes"];
}


#pragma mark -
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    if (connection == newsConn)
        [newsData setLength:0];
    else if (connection == featConn)
        [featData setLength:0];
    else
        [quackData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to container.
    if (connection == newsConn) 
        [newsData appendData:data];
    else if (connection == featConn)
        [featData appendData:data];
    else
        [quackData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    //[connection release];
    // receivedData is declared as a method instance elsewhere
    //[receivedData release];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   
    NSString *responseString;
    
    if (connection == newsConn) {
        NSLog(@"Succeeded! Received %d bytes of News data",[newsData length]);
        
        
        responseString = [[NSString alloc] initWithData:newsData encoding:NSUTF8StringEncoding];
        //responseString = [responseString stringByReplacingOccurrencesOfString:@"\"'\'\"" withString:@"\""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
         
        //NSDictionary *newsArticles = [responseString JSONValue];
         
        //NSArray *newsArticles = [responseString JSONValue];
        //SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        //id jsonResponse = [jsonParser objectWithString:dataString  error:NULL];
         
         
        NSError *error;
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSArray *newsArticles = [json objectWithString:responseString error:&error];
        NSMutableString *textString = [NSMutableString stringWithString:@"Article Titles:\n"];
         
        if (newsArticles == nil) {
            NSLog(@"JSON Parsing Failed: %@",[error localizedDescription]);
            NSLog(@"%@",newsArticles);
            
         } else {
             for (int i = 0; i < [newsArticles count]; i++)
                 [textString appendFormat:@"%@\n", [newsArticles objectAtIndex:i]];
        }
         
         
         NSLog(@"%@",responseString);     
         

        
        
    } else if (connection == featConn) {
        NSLog(@"Succeeded! Received %d bytes of Featured Comic data",[featData length]);
    } else {
        NSLog(@"Succeeded! Received %d bytes of Quackcast Episode data",[quackData length]);
    }
    
}

-(NSDictionary *)downloadDuckFeed:(NSURL *)url
{
    NSError *error;
	id response = [self objectWithUrl:url orError:error];
    NSLog(@"error: %@",[error localizedDescription]);
    
	NSDictionary *feed = (NSDictionary *)response;
	return feed;
}

-(id) objectWithUrl:(NSURL *)url orError:(NSError *)err
{
	SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithUrl:url];
    
    NSLog(@"JSON: %@",jsonString);
    
	// Parse the JSON into an Object
	return [jsonParser objectWithString:jsonString error:&err];
}

-(NSString *)stringWithUrl:(NSURL *)url
{
    NSLog(@"url: %@",url);
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:60.0];
    
    // Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
    /*
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
        [self.appDelegate alertWithMessage:@"Connection Failed" withTitle:@"Error!"];
    }
    */
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSLog(@"%@",urlData);
    
 	// Construct a String around the Data from the response
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
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
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
