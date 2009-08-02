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
	NSMutableDictionary *connections;
	id<RequestDataProtocol> receiver;
}

- (id)initWithReceiver:(id<RequestDataProtocol>)dataReceiver;
- (NSString *)open:(NSString *)url;
- (NSString *)open:(NSString *)url username:(NSString *)username remoteKey:(NSString *)remotekey;
- (NSString *)openConnection;

+ (NSString *)createUniqueIdentifier;

@end
