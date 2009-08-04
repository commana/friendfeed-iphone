//
//  FriendFeedAppDelegate.m
//  FriendFeed
//
//  Created by Shane Vitarana on 3/31/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FriendFeedAppDelegate.h"
#import "HomeListController.h"
#import "PreferencesController.h"


NSString *const kFFUserName = @"FFUserName";
NSString *const kFFRemoteKey = @"FFRemoteKey";
NSString *const kFFSettingsChanged = @"FFSettingsChanged";

@implementation FriendFeedAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	FriendFeedAPI *friendFeedAPI = [[FriendFeedAPI alloc] init];
	HomeList *homeList = [[HomeList alloc] initWithAPI:friendFeedAPI];
	
	[[NSNotificationCenter defaultCenter] addObserver:friendFeedAPI selector:@selector(updateCredentials:) name:@"FFSettingsChanged" object:nil];
	
	// Create a tabbar controller and an array to contain the view controllers
	tabBarController = [[UITabBarController alloc] init];
	NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:2];
	UINavigationController *navigationController;

	HomeListController *homeListController = [(HomeListController *)[HomeListController alloc] initWithModel:homeList];
	navigationController = [[UINavigationController alloc] initWithRootViewController:homeListController];
	[homeListController release];
	[localViewControllersArray addObject:navigationController];
	[navigationController release];
	
	PreferencesController *preferencesController = [[PreferencesController alloc] initWithAPI:friendFeedAPI];
	navigationController = [[UINavigationController alloc] initWithRootViewController:preferencesController];
	[preferencesController release];
	[localViewControllersArray addObject:navigationController];
	[navigationController release];
	
	
	tabBarController.viewControllers = localViewControllersArray;
	[localViewControllersArray release];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kFFSettingsChanged object:nil];
	// Create window
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
	// Add the tab controller's view to the window
	[self.window addSubview:[self.tabBarController view]];

	// Show window
	[self.window makeKeyAndVisible];	
	
	[homeList release];
	[friendFeedAPI release];
}

- (void)dealloc {
	[window release];
	[super dealloc];
}

@end
