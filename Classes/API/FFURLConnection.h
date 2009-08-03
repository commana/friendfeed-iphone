//
//  FFURLConnection.h
//  FriendFeed
//
//  Created by Christoph Thelen on 03.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FFURLConnection : NSURLConnection
{
	NSString *uuid;
}

- (NSString *)uuid;

@end
