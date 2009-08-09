//
//  Connector.m
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Connector.h"
#import "Base64.h"
#import "FFURLConnection.h"

@implementation Connector

- (id)initWithReceiver:(id<RequestDataProtocol>)dataReceiver
{
	self = [super init];
	if (self)
	{
		receiver = [dataReceiver retain];
		request = [[NSMutableURLRequest alloc] init];
		receivedData = [[NSMutableData data] retain];
	}
	return self;
}

- (void)dealloc
{
	[request release];
	[receivedData release];
	[receiver release];
	[super dealloc];
}

- (NSString *)open:(NSString *)url
{
	[self setUpRequest:url];
	
	return [self openConnection];
}

- (NSString *)open:(NSString *)url username:(NSString *)username remoteKey:(NSString *)remotekey
{
	[self setUpRequest:url];
	
	NSString *credentials = [NSString stringWithFormat:@"%@:%@", username, remotekey];
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [credentials base64Encode]];
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
	
	return [self openConnection];
}

- (void)setUpRequest:(NSString *)url
{
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setValue:nil forHTTPHeaderField:@"Authorization"];
}

- (NSString *)openConnection
{
	FFURLConnection *connection = [[FFURLConnection alloc] initWithRequest:request delegate:self];
	if (! connection)
	{
		NSLog(@"Failed to create FFURLConnection object.");
		[receiver dataHasNotArrived:nil error:nil];
		return nil;
	}
	return [connection uuid];
}

- (void)connection:(FFURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(FFURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(FFURLConnection *)connection
{
	[receiver dataHasArrived:receivedData identifier:[connection uuid]];
	[connection release];
}

- (void)connection:(FFURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"FFURLConnection %@ didFailWithError: %@", [connection description], [error description]);
	[receiver dataHasNotArrived:[connection uuid] error:error];
	[connection release];
}

//NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

//NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

//[request setURL:[NSURL URLWithString:@"http://friendfeed.com/api/feed/home"]];
//[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//[request setHTTPBody:postData];

@end
