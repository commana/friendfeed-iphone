//
//  PictureFeedHandler.h
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeedHandler.h"

@class ImageCache;

@interface PictureFeedHandler : FeedHandler
{
	ImageCache *imageCache;
}

- (id)initWithImageCache:(ImageCache *)cache;

- (BOOL)isURLCached:(NSString *)theURL;
- (UIImage *)getCachedImage:(NSString *)theURL;

- (void)processCachedData:(UIImage *)image forClient:(id)object;

@end
