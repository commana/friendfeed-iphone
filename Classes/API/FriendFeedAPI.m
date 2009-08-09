//
//  FriendFeedAPI.m
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FriendFeedAPI.h"


@implementation FriendFeedAPI

- (id)initWithImageCache:(ImageCache *)cache
{
	self = [super init];
	if (self)
	{
		connector = [[Connector alloc] initWithReceiver:self];
		imageCache = [cache retain];
		apiCalls = [[NSMutableDictionary alloc] init];
		receivers = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[self releaseCredentials];
	
	[connector release];
	[imageCache release];
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
	[self setUsername:[[NSUserDefaults standardUserDefaults] valueForKey:kFFUserName] remoteKey:[[NSUserDefaults standardUserDefaults] valueForKey:kFFRemoteKey]];
}

- (void)setUsername:(NSString *)name remoteKey:(NSString *)key
{
	[self releaseCredentials];
	username = [name copy];
	remotekey = [key copy];
}

- (void)fetchHomeFeed:(NSString *)service start:(int)start num:(int)num receiver:(id)object
{
	[self fetchFeed:@"feed/home" receiver:object feedType:FFAPI_FEED_HOME authenticate:YES];
}

- (void)fetchPublicFeed:(NSString *)service start:(int)start num:(int)num receiver:(id)object
{
	[self fetchFeed:@"feed/public" receiver:object feedType:FFAPI_FEED_PUBLIC authenticate:NO];
}

- (void)fetchFeed:(NSString *)urlPart receiver:(id)object feedType:(int)feedType authenticate:(BOOL)needsAuthentication
{
	NSString *url = [NSString stringWithFormat:@"%@%@", FFAPI_URL, urlPart];
	NSString *uuid = (needsAuthentication)
							? [connector open:url username:username remoteKey:remotekey]
							: [connector open:url];
	if (! uuid)
	{
		NSLog(@"Could not open connection.");
		[object performSelector:@selector(connectionFailed:)];
		return;
	}
	FeedHandler *feedHandler = [[[DefaultFeedHandler alloc] initWithFeedType:feedType] autorelease];
	[self setUpRequestHandler:feedHandler forURL:url withReceiver:object uuid:uuid];
}

- (void)fetchProfilePicture:(NSString *)profile receiver:(id)object
{
	NSString *url = [NSString stringWithFormat:@"%@%@%@?size=medium", FFAPI_URL, @"picture/", profile];
	NSString *uuid = [connector open:url];
	if (! uuid)
	{
		// no error handling for images
		return;
	}
	FeedHandler *feedHandler = [[[PictureFeedHandler alloc] init] autorelease];
	[self setUpRequestHandler:feedHandler forURL:url withReceiver:object uuid:uuid];
}

- (void)setUpRequestHandler:(FeedHandler *)handler forURL:(NSString *)url withReceiver:(id)object uuid:(NSString *)uuid
{
	[handler addURL:url];
	[handler addReceiver:object];
	
	[apiCalls setObject:handler forKey:uuid];
}

- (void)dataHasArrived:(NSData *)data identifier:(NSString *)uuid
{
	FeedHandler *feedHandler = [apiCalls objectForKey:uuid];
	[feedHandler processData:data];
	[apiCalls removeObjectForKey:uuid];
}

- (void)dataHasNotArrived:(NSString *)uuid error:(NSError *)error
{
	NSLog(@"%@: error occured", uuid);
	if (! uuid)
	{
		// connection failed, but receiver has already been informed.
		return;
	}
	
	FeedHandler *feedHandler = [apiCalls objectForKey:uuid];
	[feedHandler connectionFailed:error];
	[apiCalls removeObjectForKey:uuid];
}

@end
