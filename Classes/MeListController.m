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

@synthesize containerView;

- (id)initWithModel:(MeList *)model
{
	if (self = [super init]) {
		self.title = @"Me";
		self.tabBarItem.image = [UIImage imageNamed:@"flickr.png"];
		
		me = [model retain];
	}
	return self;
}

// FIXME
-(void) settingsChange: (NSNotification *)note
{
	NSLog(@"loading with new param");
	NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"FFUserName"];
	if (userName == nil) userName = @"commana";
	NSString *remoteKey =  [[NSUserDefaults standardUserDefaults] valueForKey:@"FFRemoteKey"];
	if (remoteKey == nil) remoteKey = @"yooy";
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
	FeedItemTableViewCell *cell = [self createFeedItemCell];
	cell.feedItem = [me getFeedItemAtIndex:indexPath.row];
	
	return cell;
}

- (FeedItemTableViewCell *)createFeedItemCell
{
	CGSize size = CGSizeMake(300, 36);
	CGRect cellFrame = CGRectMake(0,0,size.width,size.height);
	return [[[FeedItemTableViewCell alloc] initWithFrame:cellFrame] autorelease];	
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
	return [me getNumberOfItems];
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

- (void)dealloc
{
	[me release];
	[super dealloc];
}

@end
