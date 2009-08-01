//
//  Connector.m
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Connector.h"

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

- (void)open:(NSString *)url
{
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	
	NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
	if (! connection) 
	{
		[receiver dataHasNotArrived];
		return;
	}
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
	[receiver dataHasArrived:receivedData];
	[connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[receiver dataHasNotArrived];
	[connection release];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

//NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

//NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//NSString *authValue = [NSString stringWithFormat:@"Basic %@", @"c2hhbmV2Om1hcmVzODM3ZGluZXM="];
//[request setValue:authValue forHTTPHeaderField:@"Authorization"];

//[request setURL:[NSURL URLWithString:@"http://friendfeed.com/api/feed/home"]];
//[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//[request setHTTPBody:postData];

@end
