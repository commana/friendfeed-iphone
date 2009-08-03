//
//  EveryoneList.m
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EveryoneList.h"


@implementation EveryoneList

- (void)loadWithReceiver:(UIViewController *)receiver selector:(SEL)sel
{
	[super loadWithReceiver:receiver selector:sel];
	[api fetchPublicFeed:nil start:0 num:0 receiver:self];
}

@end
