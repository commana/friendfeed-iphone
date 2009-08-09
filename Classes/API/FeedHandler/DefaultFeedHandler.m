//
//  DefaultFeedHandler.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DefaultFeedHandler.h"


@implementation DefaultFeedHandler

- (id)initWithFeedType:(int)type
{
	self = [super init];
	if (self)
		feedType = type;
	return self;
}

- (id)createJSONObject:(NSData *)data
{
	if ([data length] == 0) return nil;
	
	id jsonObject = NULL;
    NSString *receivedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSScanner *theScanner = [NSScanner scannerWithString:receivedData];
	[theScanner scanJSONObject:&jsonObject];
	
	[receivedData release];
	[jsonObject retain];
	
	return [jsonObject autorelease];
}

- (void)processData:(NSData *)data
{
	JSONObject = [self createJSONObject:data];
	if (feedType == FFAPI_FEED_HOME)
		[self informClient:@selector(receivedHomeFeed:) withObject:JSONObject];
	else
		[self informClient:@selector(receivedPublicFeed:) withObject:JSONObject];
}

@end
