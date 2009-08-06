//
//  MeListController.m
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HomeListController.h"
#import	"FeedItem.h"

@implementation HomeListController

@synthesize containerView;

- (id)initWithModel:(HomeList *)homeListModel
{
	if (self = [super init]) {
		self.title = @"Home";
		self.tabBarItem.image = [UIImage imageNamed:@"flickr.png"];
		
		model = [homeListModel retain];
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

- (void)viewDidLoad
{
	UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] 
									 initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
									 target:self
									 action:@selector(viewWillAppear:)];
	
	self.navigationItem.rightBarButtonItem = reloadButton;
	
	[reloadButton release];
}

- (void)reloadData:(NSString *)error
{
	if (error)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed loading feed" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		[(UITableView *)self.view reloadData];
	}
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
	[model loadWithReceiver:self selector:@selector(reloadData:)];
}

- (void)dealloc
{
	[model release];
	[super dealloc];
}

@end
