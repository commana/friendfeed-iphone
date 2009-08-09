#import "NewFeedItemTableViewCell.h"

@implementation NewFeedItemTableViewCell

@synthesize profilePictureView;
@synthesize author;
@synthesize content;
@synthesize feedItem;

- (void)registerFeedItem:(FeedItem *)feed
{
	self.feedItem = feed;
}

- (void)prepareForReuse
{
	self.feedItem = nil;
}

- (void)updateProfilePicture:(UIImage *)image fromFeedItem:(FeedItem *)updater
{
	if (self.feedItem != updater) return;
	
	self.profilePictureView.image = image;
}

@end
