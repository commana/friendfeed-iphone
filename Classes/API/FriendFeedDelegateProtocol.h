//
//  FriendFeedProtocol.h
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FriendFeedDelegateProtocol <NSObject>

@optional

- (void)connectionFailed:(NSError *)error;

/*
Returns the entries the authenticated user would see on their
FriendFeed homepage - all of their subscriptions and friend-of-a-friend
entries. Authentication is always required.
*/
- (void)receivedHomeFeed:(id)feed;

/*
Returns the most recent public entries on FriendFeed.
*/
- (void)receivedPublicFeed:(id)feed;

- (void)receivedProfilePicture:(id)picture;

@end

