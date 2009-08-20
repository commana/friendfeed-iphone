//
//  ImageCache.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"
#import "FFOperation.h"

@implementation ImageCache

- (id)initWithAPI:(FriendFeedAPI *)ffapi;
{
	self = [super init];
	if (self)
	{
		api = [ffapi retain];
		cache = [[NSMutableDictionary alloc] init];
		queue = [[NSOperationQueue alloc] init];
		[queue setMaxConcurrentOperationCount:2];
	}
	return self;
}

- (void)dealloc
{
	[api release];
	[cache release];
	[queue release];
	[super dealloc];
}

- (UIImage *)getProfilePicture:(NSString *)feedId
{
	UIImage *picture = [cache objectForKey:feedId];
	if (! picture)
	{
		FFOperation *imageLoader = [[FFOperation alloc] initWithObject:self andMethod:@selector(loadImage:) withObject:feedId];
		[queue addOperation:imageLoader];
		[imageLoader release];
		
		picture = [UIImage imageNamed:@"nopic.png"];
	}
	return picture;
}

- (void)loadImage:(NSString *)feedId
{
	UIImage *profilePicture = [api fetchProfilePicture:feedId];
	[self receivedPicture:profilePicture forProfile:feedId];
}

- (void)receivedPicture:(id)picture forProfile:(NSString *)feedId
{
	[cache setObject:picture forKey:feedId];
}

@end
