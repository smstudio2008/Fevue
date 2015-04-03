//
//  instaViewimageController.h
//  fevue
//
//  Created by SALEM on 24/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBInstagramModel.h"
#import <AVFoundation/AVFoundation.h>
#import "AAShareBubbles.h"


@interface instaViewimageController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (assign, nonatomic) SBInstagramMediaEntity* entity;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) UIImageView *userImage;


//video player
@property (strong, nonatomic) UIButton *controlButton;
@property (strong, nonatomic) UIImageView *videoPlayImage;
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL loadComplete;


+ (id) imageViewerWithEntity:(SBInstagramMediaEntity *)entity;

- (IBAction)dismiss;


@end