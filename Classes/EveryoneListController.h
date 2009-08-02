//
//  EveryoneListController.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EveryoneList.h"
#import "FeedItemTableViewCell.h"

@interface EveryoneListController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	EveryoneList *model;
	UIView *containerView;	
}

@property (nonatomic,retain) UIView *containerView;

- (id)initWithModel:(EveryoneList *)model;

- (FeedItemTableViewCell *)createFeedItemCell;

@end
