//
//  MeListController.h
//  FriendFeed
//
//  Created by Shane Vitarana on 4/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeList.h"

@interface HomeListController : UIViewController <UITableViewDelegate>
{
	HomeList *model;
	UIView *containerView;
	
	IBOutlet UITableViewCell *cell;
}

@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UITableViewCell *cell;

- (id)initWithModel:(HomeList *)model;

@end
