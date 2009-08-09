//
//  FeedHandler.h
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedHandler : NSObject
{
	NSString *url;
	id receiver;
}

- (void)addURL:(NSString *)url;
- (void)addReceiver:(id)object;
- (void)processData:(NSData *)data;
- (void)connectionFailed:(NSError *)error;

- (void)informClient:(SEL)apiMethod withObject:object;

@end
