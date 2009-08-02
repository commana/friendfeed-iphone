//
//  MeList.h
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"
#import "FeedItem.h"

@interface MeList : NSObject
{
	FriendFeedAPI *api;
	NSMutableArray *feedItems;
}

- (id)initWithAPI:(FriendFeedAPI *)ffapi;

- (void)load;
- (void)receivedHomeFeed:(id)data;
- (void)addFeedItem:(NSDictionary *)element;

- (int)getNumberOfItems;
- (FeedItem *)getFeedItemAtIndex:(int)index;

@end
