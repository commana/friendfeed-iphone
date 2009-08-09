#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class FeedItem;

@interface NewFeedItemTableViewCell : UITableViewCell
{
    IBOutlet UILabel *author;
    IBOutlet UIImageView *profilePictureView;
    IBOutlet UILabel *content;
	
	FeedItem *feedItem;
}

@property (nonatomic, retain) UILabel *author;
@property (nonatomic, retain) UILabel *content;
@property (nonatomic, retain) UIImageView *profilePictureView;

@property (nonatomic, assign) FeedItem *feedItem;

- (void)updateProfilePicture:(UIImage *)image fromFeedItem:(FeedItem *)updater;

@end
