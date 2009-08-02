//
//  MeListController.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeList.h"
#import "FeedItemTableViewCell.h"

@interface HomeListController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	HomeList *model;
	UIView *containerView;	
}

@property (nonatomic, retain) UIView *containerView;

- (id)initWithModel:(HomeList *)model;

- (FeedItemTableViewCell *)createFeedItemCell;

@end
