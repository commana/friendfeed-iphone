//
//  FFURLConnection.m
//  FriendFeed
//
//  Created by Christoph Thelen on 03.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFURLConnection.h"


@implementation FFURLConnection

- (NSString *)uuid
{
	if (uuid) return uuid;
	
	CFUUIDRef uuidref = CFUUIDCreate(kCFAllocatorDefault);
	uuid = (id)CFUUIDCreateString(kCFAllocatorDefault, uuidref);
	CFRelease(uuidref);
	return uuid;
}

- (void)dealloc
{
	if (uuid) [uuid release];
	[super dealloc];
}

@end
