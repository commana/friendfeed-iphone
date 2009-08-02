//
//  MeListController.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MeList.h"
#import "FeedItemTableViewCell.h"

@interface MeListController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	MeList *me;
	UIView *containerView;	
}

@property (nonatomic, retain) UIView *containerView;

- (id)initWithModel:(MeList *)model;

- (FeedItemTableViewCell *)createFeedItemCell;

@end
