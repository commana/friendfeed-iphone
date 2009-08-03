//
//  FriendFeedAppDelegate.h
//  FriendFeed
//
//  Created by Shane Vitarana on 3/31/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kFFUserName;
extern NSString *const kFFRemoteKey;
extern NSString *const kFFSettingsChanged;

@interface FriendFeedAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
