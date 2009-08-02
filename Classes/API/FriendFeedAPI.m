//
//  FriendFeedAPI.m
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FriendFeedAPI.h"


@implementation FriendFeedAPI

- (id)init
{
	self = [super init];
	if (self)
	{
		connector = [[Connector alloc] initWithReceiver:self];
		apiCalls = [[NSMutableDictionary alloc] init];
		receivers = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[self releaseCredentials];
	[connector release];
	[apiCalls release];
	[receivers release];
	[super dealloc];
}

- (void)releaseCredentials
{
	if (username)
		[username release];
	if (remotekey)
		[remotekey release];
}

- (void)updateCredentials:(NSNotification *)notification
{
	[self setUsername:[[NSUserDefaults standardUserDefaults] valueForKey:@"FFUserName"] remoteKey:[[NSUserDefaults standardUserDefaults] valueForKey:@"FFRemoteKey"]];
}

- (void)setUsername:(NSString *)name remoteKey:(NSString *)key
{
	[self releaseCredentials];
	username = [name copy];
	remotekey = [key copy];
}

- (void)fetchHomeFeed:(NSString *)service start:(int)start num:(int)num receiver:(id)object
{
	NSString *url = [NSString stringWithFormat:@"%@%@", FFAPI_URL, @"feed/home"];
	NSString *uuid = [connector open:url username:username remoteKey:remotekey];
	if (! uuid) return;
	
	[apiCalls setObject:[NSNumber numberWithInt:FFAPI_FEED_HOME] forKey:uuid];
	[receivers setObject:object forKey:uuid];
}

- (void)fetchPublicFeed:(NSString *)service start:(int)start num:(int)num receiver:(id)object
{
	NSString *url = [NSString stringWithFormat:@"%@%@", FFAPI_URL, @"feed/public"];
	NSString *uuid = [connector open:url];
	if (! uuid) return;
	
	[apiCalls setObject:[NSNumber numberWithInt:FFAPI_FEED_PUBLIC] forKey:uuid];
	[receivers setObject:object forKey:uuid];
}

- (id)createJSONObject:(NSData *)data
{
	id jsonObject = NULL;
    NSString *receivedData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	NSScanner *theScanner = [NSScanner scannerWithString:receivedData];
	[theScanner scanJSONObject:&jsonObject];
	
	[receivedData release];
	[jsonObject retain];
	
	return [jsonObject autorelease];
}

- (void)dataHasArrived:(NSData *)data identifier:(NSString *)uuid
{
	NSLog(@"%@: received data length: %d", uuid, [data length]);
	
	id jsonObject = [self createJSONObject:data];
	
	int api = [[apiCalls objectForKey:uuid] intValue];
	id object = [receivers objectForKey:uuid];
	switch (api)
	{
		case FFAPI_FEED_HOME:
			if ([object respondsToSelector:@selector(receivedHomeFeed:)])
			{
				[object performSelector:@selector(receivedHomeFeed:) withObject:jsonObject];
			}
			break;
			
		case FFAPI_FEED_PUBLIC:
			if ([object respondsToSelector:@selector(receivedPublicFeed:)])
			{
				[object performSelector:@selector(receivedPublicFeed:) withObject:jsonObject];
			}
			break;
			
		default:
			NSLog(@"Received unknown API call");
			break;
	}
	[apiCalls removeObjectForKey:uuid];
	[receivers removeObjectForKey:uuid];
}

- (void)dataHasNotArrived:(NSString *)uuid
{
	NSLog(@"%@: error occured", uuid);
	[apiCalls removeObjectForKey:uuid];
	[receivers removeObjectForKey:uuid];
}

@end