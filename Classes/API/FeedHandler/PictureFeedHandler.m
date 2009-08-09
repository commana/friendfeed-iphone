//
//  PictureFeedHandler.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PictureFeedHandler.h"

@implementation PictureFeedHandler

- (id)initWithImageCache:(ImageCache *)cache
{
	self = [super init];
	if (self)
		imageCache = cache;
	return self;
}

- (BOOL)isURLCached:(NSString *)theURL
{
	return [imageCache objectForKey:theURL] != nil;
}

- (UIImage *)getCachedImage:(NSString *)theURL
{
	return [imageCache objectForKey:theURL];
}

- (void)processData:(NSData *)data
{
	UIImage *image = [[[UIImage alloc] initWithData:data] autorelease];
	NSLog(@"Caching %@", url);
	[imageCache setObject:image forKey:url];
	[self informClient:@selector(receivedImage:) withObject:image];
}

- (void)processCachedData:(UIImage *)image forClient:(id)object
{
	receiver = object;
	[self informClient:@selector(receivedImage:) withObject:image];
}

@end
