//
//  MeListController.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FriendFeedDelegateProtocol.h"

@interface MeListController : UIViewController <UITableViewDelegate, UITableViewDataSource, FriendFeedDelegateProtocol>
{
	NSMutableArray *feedItems;
	UIView *containerView;	
}

@property (nonatomic, retain) NSMutableArray *feedItems;
@property (nonatomic,retain) UIView *containerView;


@end
