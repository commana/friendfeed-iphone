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

- (id)initWithImageCache:(ImageCache *)theImageCache;
{
	self = [super init];
	if (self)
	{
		imageCache = [theImageCache retain];
	}
	return self;
}

- (UIImage *)getProfilePicture
{
	return [imageCache getProfilePicture:self.feedId];
}

- (void)dealloc
{
	[imageCache release];
	[super dealloc];
}

@end
