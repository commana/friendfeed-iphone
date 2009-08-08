//
//  FeedItem.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"
#import "NewFeedItemTableViewCell.h"

@interface FeedItem : NSObject
{
	FriendFeedAPI *api;
	NewFeedItemTableViewCell *cell;
	
	UIImage *profilePicture;
	NSString *feedId;
	NSString *name;
	NSString *body;
}

@property (nonatomic, retain) NewFeedItemTableViewCell *cell;

@property (nonatomic, retain) UIImage *profilePicture;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *feedId;

- (id)initWithAPI:(FriendFeedAPI *)friendFeedAPI;

- (void)loadImage:(NewFeedItemTableViewCell *)feedCell;
- (void)receivedImage:(id)image;
- (void)connectionFailed:(NSError *)error;

@end
