//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaggableFriendsViewController.h"
#import "AAShareBubbles.h"
#import <Parse/Parse.h>
#import <ParseUI/PFLogInViewController.h>
#import <ParseUI/PFLogInView.h>
#import "Shade.h"


@interface InvitedFriendsViewController : UIViewController<FriendSelectorDelegate, UIAlertViewDelegate, PFLogInViewControllerDelegate>




{
    IBOutlet UIButton *logo;
        IBOutlet UIImageView *imgViewBG;
}

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic)  NSData *imageshare;
@end