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

- (void)addFeedItem:(NSDictionary *)element
{
	NSDictionary *user = [element objectForKey:@"user"];
	NSString *nickname = [user objectForKey:@"nickname"];
	NSDictionary *service = [element objectForKey:@"service"];
	NSString *serviceId = [service objectForKey:@"id"];
	NSString *serviceName = [service objectForKey:@"name"];
	NSString *entryTitle = [element objectForKey:@"title"];
	
	FeedItem *feedItem = [[FeedItem alloc] init];
	feedItem.nickName = nickname;
	feedItem.title = entryTitle;
	feedItem.serviceId = serviceId;
	feedItem.serviceName = serviceName;
	
	[feedItems addObject:feedItem];
	[feedItem release];
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

@end
