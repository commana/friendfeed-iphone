//
//  MeList.m
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HomeList.h"


@implementation HomeList

@synthesize feedCell;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [self getNumberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *identifier = @"FeedItemCell";
	
	NewFeedItemTableViewCell *cell = (NewFeedItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
	if (! cell)
	{
		cell = [self loadCell];
	}
	
	FeedItem *item = [self getFeedItemAtIndex:indexPath.row];
	cell.profilePictureView.image = [item getProfilePicture];
	cell.author.text = item.feedId;
	cell.content.text = item.body;
	
	return cell;
}

- (NewFeedItemTableViewCell *)loadCell
{
	[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
	NewFeedItemTableViewCell *cell = self.feedCell;
	self.feedCell = nil;
	return cell;
}

- (void)loadWithReceiver:(UIViewController *)receiver selector:(SEL)sel
{
	controller = receiver;
	message = sel;
	[api fetchHomeFeed:nil start:0 num:0 receiver:self];
}

@end
