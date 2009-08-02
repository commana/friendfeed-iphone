//
//  EveryoneList.m
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EveryoneList.h"


@implementation EveryoneList

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
	[api fetchPublicFeed:nil start:0 num:0 receiver:self];
	controller = receiver;
	message = sel;
}

- (void)receivedPublicFeed:(id)receivedData
{
	[feedItems removeAllObjects];
	
	id anObject = [receivedData objectForKey:@"entries"];
	
	for (NSDictionary *element in anObject) {
		[self addFeedItem:element];
	}
	[controller performSelector:message];
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

@end
