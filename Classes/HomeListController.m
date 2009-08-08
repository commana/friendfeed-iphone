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
@synthesize cell;

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
	tableView.dataSource = model;

	self.containerView = tableView;
	[tableView release];
	
	self.view = containerView;
}

- (void)viewDidLoad
{
	UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] 
									 initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
									 target:self
									 action:@selector(forceReload)];
	
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

- (void)tableView:(UITableView *)tableView selectionDidChangeToIndexPath:(NSIndexPath *)newIndexPath fromIndexPath:(NSIndexPath *)oldIndexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75;
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

- (void)forceReload
{
	model.errorOccured = NO;
	[self viewWillAppear:NO];
}

- (void)dealloc
{
	[model release];
	[super dealloc];
}

@end
