//
//  Connector.m
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Connector.h"
#import "Base64.h"

@implementation Connector

+ (NSString *)createUniqueIdentifier
{
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	NSString *identifier = (id)CFUUIDCreateString(kCFAllocatorDefault, uuid);
	CFRelease(uuid);
	return [identifier autorelease];
}

- (id)initWithReceiver:(id<RequestDataProtocol>)dataReceiver
{
	self = [super init];
	if (self)
	{
		receiver = [dataReceiver retain];
		request = [[NSMutableURLRequest alloc] init];
		receivedData = [[NSMutableData data] retain];
		connections = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[request release];
	[receivedData release];
	[receiver release];
	[connections release];
	[super dealloc];
}

- (NSString *)open:(NSString *)url
{
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	return [self openConnection];
}

- (NSString *)open:(NSString *)url username:(NSString *)username remoteKey:(NSString *)remotekey
{
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	
	NSString *credentials = [NSString stringWithFormat:@"%@:%@", username, remotekey];
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [credentials base64Encode]];
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
	
	return [self openConnection];
}

- (NSString *)openConnection
{
	NSURLConnection *connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
	if (! connection)
	{
		[receiver dataHasNotArrived:nil];
		return nil;
	}
	NSString *uuid = [Connector createUniqueIdentifier];
	[connections setObject:uuid forKey:[connection description]];
	
	return uuid;	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *uuid = [connections objectForKey:[connection description]];
	[receiver dataHasArrived:receivedData identifier:uuid];
	
	[connections removeObjectForKey:[connection description]];
	[connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSString *uuid = [connections objectForKey:connection];
	[receiver dataHasNotArrived:uuid];
	
	[connections removeObjectForKey:connection];
	[connection release];
}

//NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

//NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

//[request setURL:[NSURL URLWithString:@"http://friendfeed.com/api/feed/home"]];
//[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//[request setHTTPBody:postData];

@end
