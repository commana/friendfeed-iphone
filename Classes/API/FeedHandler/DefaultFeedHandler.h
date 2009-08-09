//
//  DefaultFeedHandler.h
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"
#import "FeedHandler.h"
#import "CJSONScanner.h"

@interface DefaultFeedHandler : FeedHandler
{
	int feedType;
	id JSONObject;
}

- (id)initWithFeedType:(int)type;

@end
