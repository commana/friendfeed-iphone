//
//  MeListController.m
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MeListController.h"
#import "FeedItemTableViewCell.h"
#import	"FeedItem.h"
#import "CJSONScanner.h"
#import "FeedItemTableViewCell.h"
#import "Base64.h"
#import "PreferencesController.h"
#import "FriendFeedAPI.h"

@implementation MeListController

@synthesize feedItems;
@synthesize containerView;

- (id)init
{
	if (self = [super init]) {
		// Initialize your view controller.
		self.title = @"Me";
		self.tabBarItem.image = [UIImage imageNamed:@"flickr.png"];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChange:) name:@"FFSettingsChanged" object:nil];
	}
	return self;
}

-(void) initConnectionForUserName:(NSString *)username remoteKey:(NSString *)remotekey
{
	FriendFeedAPI *ff = [[FriendFeedAPI alloc] init];
	[ff setUsername:username remoteKey:remotekey];
	[ff fetchHomeFeed:nil start:0 num:0 receiver:self];
}


// FIXME
-(void) settingsChange: (NSNotification *)note
{
	NSLog(@"loading with new param");
	NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"FFUserName"];
	if (userName == nil) userName = @"commana";
	NSString *remoteKey =  [[NSUserDefaults standardUserDefaults] valueForKey:@"FFRemoteKey"];
	if (remoteKey == nil) remoteKey = @"yooy";
	
	[self initConnectionForUserName:userName remoteKey:remoteKey];
	
}


- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	
    tableView.delegate = self;
	tableView.dataSource = self;
	tableView.rowHeight = 48.0;
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableView.sectionHeaderHeight = 0;

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

- (void)tableView:(UITableView *)tableView selectionDidChangeToIndexPath:(NSIndexPath *)newIndexPath fromIndexPath:(NSIndexPath *)oldIndexPath
{
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

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}

- (void)connectionDidFinishLoading:(id)receivedData
{
	id anObject = [receivedData objectForKey:@"entries"];
	
	self.feedItems = [NSMutableArray array];
	
	for (NSDictionary *element in anObject) {
		NSDictionary *user = [element objectForKey:@"user"];
		NSString *nickname = [user objectForKey:@"nickname"];
		NSDictionary *service = [element objectForKey:@"service"];
		NSString *serviceId = [service objectForKey:@"id"];
		NSString *serviceName = [service objectForKey:@"name"];
		NSString *entryTitle = [element objectForKey:@"title"];
		//NSLog(@"title: %@", entryTitle);
		
		FeedItem *feedItem = [[FeedItem alloc] init];
		feedItem.nickName = nickname;
		feedItem.title = entryTitle;
		feedItem.serviceId = serviceId;
		feedItem.serviceName = serviceName;
	
		[feedItems addObject:feedItem];
		[feedItem release];
	}
	
	[self reloadData];
}


- (void)dealloc
{
	[super dealloc];
}

- (void)receivedHomeFeed:(id)data
{
	NSLog(@"received home feed");
	[self connectionDidFinishLoading:data];
}

@end
