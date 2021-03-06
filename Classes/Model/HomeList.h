//
//  MeList.h
//  FriendFeed
//
//  Created by Christoph Thelen on 02.08.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FFList.h"
#import "NewFeedItemTableViewCell.h"

@interface HomeList : FFList <UITableViewDataSource>
{
	IBOutlet NewFeedItemTableViewCell *feedCell;
}

@property (nonatomic, retain) NewFeedItemTableViewCell *feedCell;

- (NewFeedItemTableViewCell *)loadCell;

@end
