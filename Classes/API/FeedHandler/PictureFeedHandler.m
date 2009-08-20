//
//  PictureFeedHandler.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PictureFeedHandler.h"

@implementation PictureFeedHandler

- (void)processData:(NSData *)data
{
	UIImage *image = [[[UIImage alloc] initWithData:data] autorelease];
	[self informClient:@selector(receivedImage:) withObject:image];
}

@end
