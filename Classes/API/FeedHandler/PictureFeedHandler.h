//
//  PictureFeedHandler.h
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeedHandler.h"


@interface PictureFeedHandler : FeedHandler
{
	NSString *feedId;
}

- (id)initWithFeedId:(NSString *)theFeedId;

@end
