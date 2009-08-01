//
//  RequestDataProtocol.h
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RequestDataProtocol <NSObject>

- (void)dataHasArrived:(NSData *)receivedData;
- (void)dataHasNotArrived;

@end

