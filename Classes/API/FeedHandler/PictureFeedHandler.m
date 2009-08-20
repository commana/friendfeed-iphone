//
//  PictureFeedHandler.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PictureFeedHandler.h"

@implementation PictureFeedHandler

- (id)initWithFeedId:(NSString *)theFeedId
{
	self = [super init];
	if (self)
	{
		feedId = [theFeedId copy];
	}
	return self;
}

- (void)dealloc
{
	[feedId release];
	[super dealloc];
}

- (void)processData:(NSData *)data
{
	UIImage *image = [[[UIImage alloc] initWithData:data] autorelease];
	[self informClient:@selector(receivedPicture:forProfile:) withObject:image withObject:feedId];
}

@end
