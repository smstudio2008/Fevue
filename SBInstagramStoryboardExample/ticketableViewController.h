//
//  ticketableViewController.h
//  fevue
//
//  Created by SALEM on 25/01/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Flurry.h"
@interface ticketableViewController : UIViewController { NSArray *maintitles; }

@property (weak, nonatomic) IBOutlet UITableView *festivalTable;


@end
