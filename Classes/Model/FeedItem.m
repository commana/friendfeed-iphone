//
//  FeedItem.m
//  FriendFeed
//
//  Created by Shane Vitarana on 4/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "FeedItem.h"


@implementation FeedItem

@synthesize feedId;
@synthesize name;
@synthesize body;
@synthesize profilePicture;
@synthesize cell;

- (id)initWithAPI:(FriendFeedAPI *)friendFeedAPI
{
	self = [super init];
	if (self)
	{
		api = [friendFeedAPI retain];
	}
	return self;
}

- (void)loadImage:(NewFeedItemTableViewCell *)feedCell
{
	[api fetchProfilePicture:self.feedId receiver:self];
	self.cell = feedCell;
}

- (void)receivedImage:(id)image
{
	self.profilePicture = image;
	cell.profilePictureView.image = image;
}

- (void)connectionFailed:(NSError *)error
{
	NSLog(@"Error occured: %@", [error localizedDescription]);
}

- (void)dealloc
{
	[api release];
	[super dealloc];
}

@end
