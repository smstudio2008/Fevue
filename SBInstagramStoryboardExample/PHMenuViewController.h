//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "PHAirViewController.h"


@interface PHMenuViewController : PHAirViewController <PHAirMenuDataSource, PHAirMenuDelegate>


@property (nonatomic, strong) NSArray *viewControllers;


@end