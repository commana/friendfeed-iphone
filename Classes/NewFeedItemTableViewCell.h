#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NewFeedItemTableViewCell : UITableViewCell
{
    IBOutlet UILabel *author;
    IBOutlet UIImageView *profilePictureView;
    IBOutlet UILabel *content;
}

@property (nonatomic, retain) UILabel *author;
@property (nonatomic, retain) UILabel *content;
@property (nonatomic, retain) UIImageView *profilePictureView;

@end
