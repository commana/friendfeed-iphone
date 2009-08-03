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

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	if (theTextField == userName || theTextField == remoteKey)
	{
		[theTextField resignFirstResponder];
	}
	return YES;
}

- (void)dealloc
{
	[api release];
	[super dealloc];
}

- (IBAction)applySettings
{
	[[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"FFUserName"];
	[[NSUserDefaults standardUserDefaults] setObject:remoteKey.text forKey:@"FFRemoteKey"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FFSettingsChanged" object:nil];
}

@end
