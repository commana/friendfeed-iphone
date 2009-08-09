//
//  ImageCache.m
//  FriendFeed
//
//  Created by Christoph Thelen on 09.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"


@implementation ImageCache

- (id)init
{
	self = [super init];
	if (self)
		cache = [[NSMutableDictionary alloc] init];
	return self;
}

- (void)dealloc
{
	[cache release];
	[super dealloc];
}

- (void)setObject:(id)object forKey:(NSString *)key
{
	[cache setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key
{
	return [cache objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
	[cache removeObjectForKey:key];
}

@end
