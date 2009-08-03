//
//  MeList.m
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HomeList.h"


@implementation HomeList

- (void)loadWithReceiver:(UIViewController *)receiver selector:(SEL)sel
{
	[super loadWithReceiver:receiver selector:sel];
	[api fetchHomeFeed:nil start:0 num:0 receiver:self];
}

@end
