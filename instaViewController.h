//
//  instaViewController.h
//  fevue
//
//  Created by SALEM on 24/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "instacellController.h"
#import  "instaRefreshController.h"



#define SB_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define SB_showAlert(Title, Message, CancelButton) UIAlertView * alert = [[UIAlertView alloc] initWithTitle:Title message:Message delegate:nil cancelButtonTitle:CancelButton otherButtonTitles:nil, nil]; \
[alert show];



@interface instaViewController : UICollectionViewController
{
    instaRefreshController *refreshControl_;
    UISegmentedControl *segmentedControl_;
    BOOL loaded_;
}
@property (nonatomic, readonly) NSString *version;

@property (nonatomic, assign) BOOL isSearchByTag;
@property (nonatomic, strong) NSString *searchTag;

@property (nonatomic, assign) BOOL showOnePicturePerRow;
@property (nonatomic, assign) BOOL showSwitchModeView;

- (void) refreshCollection2;
- (void) showContentController: (UIViewController*)content;
- (void) dismissContentController;

@end
