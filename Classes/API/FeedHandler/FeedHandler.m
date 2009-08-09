//
//  FeedHandler.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FeedHandler.h"


@implementation FeedHandler

- (void)dealloc
{
	[url release];
	[receiver release];
	[super dealloc];
}

- (void)addURL:(NSString *)theURL
{
	[url release];
	url = [theURL copy];
}

- (void)addReceiver:(id)object
{
	[receiver release];
	receiver = [object retain];
}

- (void)processData:(NSData *)data
{
	// implemented by subclasses
}

- (void)connectionFailed:(NSError *)error
{
	[receiver performSelector:@selector(connectionFailed:) withObject:error];
}

- (void)informClient:(SEL)apiMethod withObject:object
{
	if ([receiver respondsToSelector:apiMethod])
	{
		[receiver performSelector:apiMethod withObject:object];
	}
}

@end
