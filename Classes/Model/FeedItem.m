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

- (void)loadImageForCell:(NewFeedItemTableViewCell *)feedCell registerMessage:(SEL)helloMessage
{
	[api fetchProfilePicture:self.feedId receiver:self];
	self.cell = feedCell;
	/*
	 We need to register this FeedItem at the cell. If our internet connection
	 is slow, then it might be possible that an image is loaded for a cell
	 that is already in the reuse queue. And when it's reused it has the wrong
	 picture. This happens especially when the user flicks through the list
	 very fast.
	 When we register this object the cell can see if it is the correct image
	 (because it was sent from a FeedItem it knows). Whenever the cell is reused
	 it will forget its FeedItem and ignore the image when it arrives late.
	 */
	[feedCell performSelector:helloMessage withObject:self];
}

- (void)receivedImage:(UIImage *)image
{
	[cell updateProfilePicture:image fromFeedItem:self];
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
