//
//  FFList.m
//  FriendFeed
//
//  Created by Christoph Thelen on 03.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFList.h"


@implementation FFList

@synthesize errorOccured;

- (id)initWithAPI:(FriendFeedAPI *)ffapi
{
	self = [super init];
	if (self)
	{
		api = [ffapi retain];
		feedItems = [[NSMutableArray array] retain];
	}
	return self;
}

- (void)dealloc
{
	[api release];
	[feedItems release];
	[super dealloc];
}

- (void)loadWithReceiver:(UIViewController *)receiver selector:(SEL)sel
{
	controller = receiver;
	message = sel;
	[api fetchHomeFeed:nil start:0 num:0 receiver:self];
}

- (void)connectionFailed:(NSError *)error
{
	// maybe creating error-FeedItem is a better solution...
	if (! self.errorOccured)
	{
		self.errorOccured = YES;
		[controller performSelector:message withObject:[error localizedDescription]];
	}
}

- (int)getNumberOfItems
{
	return [feedItems count];
}

- (FeedItem *)getFeedItemAtIndex:(int)index
{
	return [feedItems objectAtIndex:index];
}

- (void)receivedPublicFeed:(id)receivedData
{
	[self handleIncomingData:receivedData];
}

- (void)receivedHomeFeed:(id)receivedData
{
	[self handleIncomingData:receivedData];
}

- (void)handleIncomingData:(id)receivedData
{
	self.errorOccured = NO;
	[feedItems removeAllObjects];
	
	NSString *errorCode = [receivedData objectForKey:@"errorCode"];
	if (errorCode)
	{
		self.errorOccured = YES;
		[controller performSelector:message withObject:errorCode];
		return;
	}
	
	id anObject = [receivedData objectForKey:@"entries"];
	
	for (NSDictionary *element in anObject)
	{
		[self addFeedItem:element];
	}
	[controller performSelector:message withObject:nil];
}

- (void)addFeedItem:(NSDictionary *)element
{
	NSDictionary *from = [element objectForKey:@"from"];
	NSString *feedId = [from objectForKey:@"id"];
	NSString *name = [from objectForKey:@"name"];
	
	NSString *body = [element objectForKey:@"body"];
	
	FeedItem *feedItem = [[FeedItem alloc] initWithAPI:api];
	feedItem.feedId = feedId;
	feedItem.name = name;
	feedItem.body = body;
	
	[feedItems addObject:feedItem];
	[feedItem release];
}

@end
