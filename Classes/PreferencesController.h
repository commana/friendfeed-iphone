#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "FriendFeedAPI.h"

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
