//
//  Connector.h
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestDataProtocol.h"

@interface Connector : NSObject {
	NSMutableURLRequest *request;
	NSMutableData *receivedData;
	id<RequestDataProtocol> receiver;
}

- (id)initWithReceiver:(id<RequestDataProtocol>)dataReceiver;
- (void)open:(NSString *)url;

@end
