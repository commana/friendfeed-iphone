#import "PreferencesController.h"

@implementation PreferencesController

- (id)initWithAPI:(FriendFeedAPI *)friendFeedAPI
{
	self = [super initWithNibName:@"settings" bundle:nil];
	if (self)
	{
		self.title = @"Preferences";
		self.tabBarItem.image = [UIImage imageNamed:@"digg.png"];
		
		api = [friendFeedAPI retain];
	}
	return self;
}

- (void)dealloc
{
	[api release];
	[super dealloc];
}

- (IBAction)applySettings
{
    NSLog(@"Username: %@, remote key: %@", userName, remoteKey);
}

@end
