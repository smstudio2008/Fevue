//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FriendSelectorDelegate <NSObject>


- (void)friendSelected: (NSDictionary*)selectedFriendDetails;


@end


@interface TaggableFriendsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>


@property (nonatomic, weak) id<FriendSelectorDelegate> delegate;


@end