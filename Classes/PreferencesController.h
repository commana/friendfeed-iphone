#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"

extern NSString *const kFFUserName;
extern NSString *const kFFRemoteKey;
extern NSString *const kFFSettingsChanged;

@interface PreferencesController : UIViewController
{
    IBOutlet UITextField *remoteKey;
    IBOutlet UITextField *userName;
    IBOutlet UILabel *status;
	
	FriendFeedAPI *api;
}

- (id)initWithAPI:(FriendFeedAPI *)friendFeedAPI;

- (IBAction)applySettings;

@end
