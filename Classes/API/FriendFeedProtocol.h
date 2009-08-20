//
//  FriendFeedProtocol.h
//  FriendFeed
//
//  Created by Christoph Thelen on 01.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//



@protocol FriendFeedProtocol <NSObject>

- (void)setUsername:(NSString *)username remoteKey:(NSString *)remotekey;

@optional
- (void)fetchHomeFeed:(NSString *)service start:(int)start num:(int)num receiver:(id)object;
- (void)fetchPublicFeed:(NSString *)service start:(int)start num:(int)num receiver:(id)object;

- (UIImage *)fetchProfilePicture:(NSString *)profile;

@end
