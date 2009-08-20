//
//  FFOperation.h
//  FriendFeed
//
//  Created by Christoph Thelen on 20.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FFOperation : NSOperation
{
	id mainObject;
	SEL mainMethod;
	id param;
}

- (id)initWithObject:(id)object andMethod:(SEL)method withObject:(id)object;

@end
