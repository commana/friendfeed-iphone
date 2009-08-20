//
//  ImageCache.h
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"

@interface ImageCache : NSObject
{
	FriendFeedAPI *api;
	
	NSMutableDictionary *cache;
	NSOperationQueue *queue;
}

- (id)initWithAPI:(FriendFeedAPI *)api;

- (UIImage *)getProfilePicture:(NSString *)feedId;

- (void)receivedPicture:(id)picture forProfile:(NSString *)feedId;

@end
