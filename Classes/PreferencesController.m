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

- (void)viewDidLoad
{
	userName.text = [[NSUserDefaults standardUserDefaults] valueForKey:kFFUserName];
	remoteKey.text = [[NSUserDefaults standardUserDefaults] valueForKey:kFFRemoteKey];
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
	[[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:kFFUserName];
	[[NSUserDefaults standardUserDefaults] setObject:remoteKey.text forKey:kFFRemoteKey];
	[[NSNotificationCenter defaultCenter] postNotificationName:kFFSettingsChanged object:nil];
}

@end
