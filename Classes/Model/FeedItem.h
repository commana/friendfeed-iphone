//
//  FeedItem.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImageCache.h"
#import "NewFeedItemTableViewCell.h"

@interface FeedItem : NSObject
{
	ImageCache *imageCache;
	NewFeedItemTableViewCell *cell;
	
	NSString *feedId;
	NSString *name;
	NSString *body;
}

@property (nonatomic, retain) NewFeedItemTableViewCell *cell;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *feedId;

- (id)initWithImageCache:(ImageCache *)theImageCache;

- (UIImage *)getProfilePicture;

@end
