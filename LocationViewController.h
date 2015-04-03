//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)NSArray *locations;
@property (nonatomic, weak) IBOutlet UISearchBar *taggableFriendsSearchBar;
@end
