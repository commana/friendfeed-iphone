//
//  FriendsListController.m
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "FriendsListController.h"
#import "FeedItemTableViewCell.h"
#import	"FeedItem.h"
#import "CJSONScanner.h"
#import "FeedItemTableViewCell.h"
#import "DetailViewController.h"
#import "Base64.h"
#import "PreferencesController.h"

@implementation FriendsListController

@synthesize receivedData;
@synthesize feedItems;
@synthesize containerView;

- (id)init
{


	if (self = [super init]) {
		// Initialize your view controller.
		self.title = @"Friends";
		self.tabBarItem.image = [UIImage imageNamed:@"seesmic.png"]; 
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChange:) name:@"FFSettingsChanged" object:nil];
		}
	return self;
}


-(void) initConnectionForUserName:(NSString *)userName
						remoteKey:(NSString *)remoteKey{
	
	
	NSString *post = @"";
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	NSString *ns = [[NSString stringWithFormat:@"%@:%@", userName, remoteKey] autorelease];
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [[ns autorelease] base64Encode]];	
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
	
	[request setURL:[NSURL URLWithString:@"http://friendfeed.com/api/feed/home"]];
	[request setHTTPMethod:@"GET"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (conn) 
	{
		receivedData = [[NSMutableData data] retain];
	} 
	else 
	{
		// inform the user that the download could not be made
	}	
}


-(void) settingsChange: (NSNotification *) note{
	NSLog(@"loading with new param");
	[self initConnectionForUserName:[[NSUserDefaults standardUserDefaults] valueForKey:@"FFUserName"] 
						  remoteKey: [[NSUserDefaults standardUserDefaults] valueForKey:@"FFRemoteKey"]];
	
}


- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	
    tableView.delegate = self;
	tableView.dataSource = self;
	tableView.rowHeight = 48.0;
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableView.sectionHeaderHeight = 0;
	//tableView.backgroundColor = [UIColor blackColor]; 
	//tableView.background.image = [UIImage imageNamed:@"logo-small.png"];
	//[tableView background [UIImage imageNamed:@"logo-small.png"]];

	self.containerView = tableView;
	[tableView release];
	
	self.view = containerView;

}

- (void)reloadData
{
	[(UITableView *)self.view reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Create a cell if necessary
	FeedItemTableViewCell *cell = nil;
	CGSize size = CGSizeMake(300, 36);
	CGRect cellFrame = CGRectMake(0,0,size.width,size.height);
	cell = [[[FeedItemTableViewCell alloc] initWithFrame:cellFrame] autorelease];

	// Set up the text for the cell
	FeedItem *feedItemForRow = [feedItems objectAtIndex:indexPath.row];	
	cell.feedItem = feedItemForRow;
	return cell;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withAvailableCell:(UITableViewCell *)availableCell {
	// Create a cell if necessary
	FeedItemTableViewCell *cell = nil;
	if (availableCell != nil) {
		cell = (FeedItemTableViewCell *)availableCell;
	} else {
		CGSize size = CGSizeMake(300, 36);
		CGRect cellFrame = CGRectMake(0,0,size.width,size.height);
		cell = [[[FeedItemTableViewCell alloc] initWithFrame:cellFrame] autorelease];
	}
	// Set up the text for the cell
	FeedItem *feedItemForRow = [feedItems objectAtIndex:indexPath.row];	
	cell.feedItem = feedItemForRow;
	return cell;

}

- (void)tableView:(UITableView *)tableView selectionDidChangeToIndexPath:(NSIndexPath *)newIndexPath fromIndexPath:(NSIndexPath *)oldIndexPath
{
	// Create the detail view lazily
	if (detailViewController == nil) {
		detailViewController = [[DetailViewController alloc] init];
	}
	// Set the detail controller's inspected item to the currently-selected item
	detailViewController.feedItem = [self.feedItems objectAtIndex:newIndexPath.row];
	[[self navigationController] pushViewController:detailViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [feedItems count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveFriendsmoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	id theObject = NULL;
	id anObject = NULL;

    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    NSString *aStr = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    NSLog(aStr);
	
	NSScanner *theScanner = [NSScanner scannerWithString:aStr];
	[theScanner scanJSONObject:&theObject];
	
	NSArray *allKeys = [theObject allKeys];
	NSLog(@"%@", allKeys);
	
	anObject = [theObject objectForKey:@"entries"];
	
	self.feedItems = [NSMutableArray array];
	
	for (NSDictionary *element in anObject) {
		NSDictionary *user = [element objectForKey:@"user"];
		NSString *nickname = [user objectForKey:@"nickname"];
		NSDictionary *service = [element objectForKey:@"service"];
		NSString *serviceId = [service objectForKey:@"id"];
		NSString *serviceName = [service objectForKey:@"name"];
		NSString *entryTitle = [element objectForKey:@"title"];
		NSString *entryLink = [element objectForKey:@"link"];
		NSArray *comments = [element objectForKey:@"comments"];
		//NSLog(@"link: %@", entryLink);
		
		FeedItem *feedItem = [[FeedItem alloc] init];
		feedItem.nickName = nickname;
		feedItem.title = entryTitle;
		feedItem.serviceId = serviceId;
		feedItem.serviceName = serviceName;
		feedItem.comments = comments;
	
		[feedItems addObject:feedItem];
		[feedItem release];
	}
	
	[self reloadData];
}


- (void)dealloc
{
	[detailViewController dealloc];
	[feedItems dealloc];
	[receivedData dealloc];
	[containerView dealloc];
	[super dealloc];
}

@end