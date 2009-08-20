//
//  FFOperation.m
//  FriendFeed
//
//  Created by Christoph Thelen on 20.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FFOperation.h"


@implementation FFOperation

- (id)initWithObject:(id)object andMethod:(SEL)method withObject:(id)parameter
{
	self = [super init];
	if (self)
	{
		mainObject = [object retain];
		mainMethod = method;
		param = [parameter retain];
	}
	return self;
}

- (void)dealloc
{
	[mainObject release];
	[param release];
	[super dealloc];
}

- (void)main
{
	[mainObject performSelector:mainMethod withObject:param];
}

@end
