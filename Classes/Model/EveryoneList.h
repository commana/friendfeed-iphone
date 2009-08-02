//
//  EveryoneList.h
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"
#import "FeedItem.h"
#import "FriendFeedDelegateProtocol.h"

@interface EveryoneList : NSObject <FriendFeedDelegateProtocol>
{
	FriendFeedAPI *api;
	NSMutableArray *feedItems;
	
	UIViewController *controller;
	SEL message;
}

- (id)initWithAPI:(FriendFeedAPI *)ffapi;

- (void)loadWithReceiver:(UIViewController *)receiver selector:(SEL)sel;
- (void)addFeedItem:(NSDictionary *)element;

- (int)getNumberOfItems;
- (FeedItem *)getFeedItemAtIndex:(int)index;
	
@end
