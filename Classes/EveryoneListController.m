//
//  EveryoneListController.m
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EveryoneListController.h"
#import	"FeedItem.h"

@implementation EveryoneListController

@synthesize containerView;

- (id)initWithModel:(EveryoneList *)everyoneListModel;
{
	if (self = [super init])
	{
		self.title = @"Everyone";
		self.tabBarItem.image = [UIImage imageNamed:@"yelp.png"]; 
		
		model = [everyoneListModel retain];
	}
	return self;
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
	cell.feedItem = [model getFeedItemAtIndex:indexPath.row];
	
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
	return [model getNumberOfItems];
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

- (void)viewWillAppear:(BOOL)animated
{
	[model loadWithReceiver:self selector:@selector(reloadData)];
}

- (void)dealloc
{
	[model release];
	[super dealloc];
}

@end
