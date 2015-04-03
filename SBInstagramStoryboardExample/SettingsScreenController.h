//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBFPopFlatButton.h"
#import "ATLabel.h"
@interface SettingsScreenController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImage *profileImage;
@property (strong, nonatomic) ATLabel *animatedLabel;
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property(nonatomic,weak)IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSString *name;

@end
