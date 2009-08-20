//
//  Connector.h
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestDataProtocol.h"

@interface Connector : NSObject
{
	NSMutableURLRequest *request;
	NSMutableData *receivedData;
	id<RequestDataProtocol> receiver;
}

- (id)initWithReceiver:(id<RequestDataProtocol>)dataReceiver;

- (NSString *)open:(NSString *)url;
- (id)open:(NSString *)url synchronous:(BOOL)isSynchronous;
- (NSString *)open:(NSString *)url username:(NSString *)username remoteKey:(NSString *)remotekey;
- (NSString *)openConnection;

- (void)setUpRequest:(NSString *)url;

@end
