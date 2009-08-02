//
//  FriendFeedAPI.h
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Connector.h"
#import "FriendFeedProtocol.h"
#import "RequestDataProtocol.h"

#define FFAPI_URL @"http://friendfeed.com/api/"
#define FFAPI_FEED_HOME   0xff100
#define FFAPI_FEED_PUBLIC 0xff101


@interface FriendFeedAPI : NSObject <FriendFeedProtocol, RequestDataProtocol>
{
	Connector *connector;
	NSString *username;
	NSString *remotekey;
	NSMutableDictionary *apiCalls;
	NSMutableDictionary *receivers;
}

- (void)updateCredentials:(NSNotification *)notification;
- (void)releaseCredentials;

@end
