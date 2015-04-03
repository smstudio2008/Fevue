//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "PHMenuViewController.h"


@implementation PHMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *backgroundView =[[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundView.image=[UIImage imageNamed:@"festival.jpg"];
    [self.view addSubview:backgroundView];
    

  [backgroundView setContentMode:UIViewContentModeScaleAspectFill];
}


#pragma mark - PHAirMenuDelegate & DataSource

- (NSInteger)numberOfSession {
    return 2;
}


- (NSInteger)numberOfRowsInSession:(NSInteger)session {
    return 4;
}




- (NSString*)titleForHeaderAtSession:(NSInteger)session {
    
return @"#FEVUE";
    
}
- (NSString*)titleForRowAtIndexPath:(NSIndexPath*)indexPath {
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return @"Discover";
                case 1:
                    return @"Festivals";
                    case 2:
                    return @"Invites";
                case 3:
                    return @"Tickets";
                default:
                    break;
            }
            
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return @"About ";
                case 1:
                    return @"Setting";
                case 2:
                    return @"Feedback";
                case 3:
                    return @" ";
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat: @"Row %ld in %ld", (long)indexPath.row, (long)indexPath.section];
}


- (UIViewController*)viewControllerForIndexPath:(NSIndexPath*)indexPath {
    int viewControllerIndex = 0;
    
    for (int i = 0; i < indexPath.section; i++) {
        viewControllerIndex += [self numberOfRowsInSession: i];
    }
    
    viewControllerIndex += indexPath.row;
    
    return self.viewControllers[viewControllerIndex];
}






@end