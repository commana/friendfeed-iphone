//
//  FFList.h
//  FriendFeed
//
//  Created by Christoph Thelen on 03.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"
#import "FriendFeedDelegateProtocol.h"
#import "FeedItem.h"

@interface FFList : NSObject <FriendFeedDelegateProtocol>
{
	FriendFeedAPI *api;
	NSMutableArray *feedItems;
	
	UIViewController *controller;
	SEL message;
	BOOL errorOccured;
}

@property (nonatomic) BOOL errorOccured;

- (id)initWithAPI:(FriendFeedAPI *)ffapi;

- (void)loadWithReceiver:(UIViewController *)receiver selector:(SEL)sel;
- (void)addFeedItem:(NSDictionary *)element;

- (int)getNumberOfItems;
- (FeedItem *)getFeedItemAtIndex:(int)index;

- (void)handleIncomingData:(id)receivedData;

@end
