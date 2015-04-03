//
//  SBInstagramImageViewController.m
//  MedellinHipHop
//
//  Created by Santiago Bustamante on 9/2/13.
//  Copyright (c) 2013 Pineapple Inc. All rights reserved.
//

#import "instaViewimageController.h"
#import "instaViewController.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Social/SocialDefines.h>
#import "Flurry.h"

@interface instaViewimageController ()<AAShareBubblesDelegate>

@end

@implementation instaViewimageController {

    float radius;
    float bubbleRadius;
}


+ (id) imageViewerWithEntity:(SBInstagramMediaEntity *)entity{
    instaViewimageController *instance = [[instaViewimageController alloc] initWithNibName:@"SBInstagramImageViewController" bundle:nil];
    instance.entity = entity;
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



//End: Added by Rohit
- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    //CGRect frame = self.imageView.frame;
    //    frame.origin = CGPointZero;
    //frame.size = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] applicationFrame]), CGRectGetWidth([[UIScreen mainScreen] applicationFrame]));
    //[self.imageView setFrame:frame];
    
    //self.containerView.center = self.view.center;
    
    
    
    self.title = @"";
    
    SBInstagramImageEntity *picEntity = self.entity.images[@"standard_resolution"];
    
    [SBInstagramModel downloadImageWithUrl:picEntity.url andBlock:^(UIImage *image, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        if (image && !error) {
            [weakSelf.imageView setImage:image];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something is wrong" message:@"Please check your Internet connection and try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    self.captionLabel.text = self.entity.caption;
    /*frame = self.captionLabel.frame;
     frame.size.width = CGRectGetWidth([[UIScreen mainScreen] applicationFrame]);
     frame.origin.y = CGRectGetMaxY(self.imageView.frame);
     self.captionLabel.frame = frame;*/
    
    self.activityIndicator.center = self.imageView.center;
    
    
    
    
    self.userImage = [[UIImageView alloc] init];
    self.userImage.frame = CGRectMake(CGRectGetMinX(self.imageView.frame) + 10, 22, 35, 35);
    self.userImage.contentMode = UIViewContentModeScaleAspectFit;
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 17.5;
    
    self.userLabel.text = self.entity.userName;
    [self.imageView.superview addSubview:self.userLabel];
    
    [self.userImage setImage:[UIImage imageNamed:[SBInstagramModel model].loadingImageName]];
    [self.imageView.superview addSubview:self.userImage];
    
    [SBInstagramModel downloadImageWithUrl:self.entity.profilePicture andBlock:^(UIImage *image2, NSError *error) {
        if (image2 && !error) {
            [weakSelf.userImage setImage:image2];
        }
    }];
    
    //video
    if (self.entity.type == SBInstagramMediaTypeVideo) {
        
        if (!_videoPlayImage) {
            _videoPlayImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        }
        [_videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
        [self.imageView.superview addSubview:_videoPlayImage];
        
        self.videoPlayImage.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - 34, CGRectGetMinY(self.imageView.frame) + 4, 30, 30);
        
        
        NSString *url = ((SBInstagramVideoEntity *) self.entity.videos[@"low_resolution"]).url;
        if ([SBInstagramModel model].playStandardResolution) {
            url = ((SBInstagramVideoEntity *) self.entity.videos[@"standard_resolution"]).url;
        }
        AVAsset* avAsset = [AVAsset assetWithURL:[NSURL URLWithString:url]];
        AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
        
        if (!self.avPlayer) {
            self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
        }else{
            [self.avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
        }
        
        if (!self.avPlayerLayer) {
            self.avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        }
        
        [self.avPlayerLayer setFrame:self.imageView.frame];
        [self.imageView.superview.layer insertSublayer:self.avPlayerLayer above:self.imageView.layer];
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.avPlayer play];
        
        if (!_loadComplete) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(loadingVideo) userInfo:nil repeats:YES];
        }
        
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPauseImageName]];
        [avPlayerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
        
        self.controlButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.controlButton.frame = self.imageView.frame;
        [self.controlButton addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView.superview addSubview:self.controlButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        
    }
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.contentScrollView.contentSize = self.containerView.frame.size;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [self.avPlayer pause];
}


- (IBAction)dismiss {
    [(instaViewController*)self.parentViewController dismissContentController];
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    if ([self.avPlayer currentItem] == [notification object]) {
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
    }
}

- (void) loadingVideo{
    self.videoPlayImage.hidden = !self.videoPlayImage.hidden;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[AVPlayerItem class]])
    {
        AVPlayerItem *item = (AVPlayerItem *)object;
        //playerItem status value changed?
        if ([keyPath isEqualToString:@"status"])
        {   //yes->check it...
            switch(item.status)
            {
                case AVPlayerItemStatusFailed:
                    if (_timer) {
                        [_timer invalidate];
                    }
                    break;
                case AVPlayerItemStatusReadyToPlay:
                    if (_timer) {
                        [_timer invalidate];
                    }
                    self.loadComplete = YES;
                    self.videoPlayImage.hidden = NO;
                    break;
                case AVPlayerItemStatusUnknown:
                    break;
            }
        }
    }
}

- (void) controlAction:(id)sender{
    if (self.avPlayer.rate == 0) {
        if (CMTimeCompare(self.avPlayer.currentItem.currentTime, self.avPlayer.currentItem.duration) == 0) {
            [self.avPlayer seekToTime:kCMTimeZero];
        }
        [self.avPlayer play];
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPauseImageName]];
        
    }else{
        [self.avPlayer pause];
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
    }
}


#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)invite:(id)sender

{
    {AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(160, 250)
                                                                   radius:100
                                                                   inView:self.view];
        shareBubbles.delegate = self;
        shareBubbles.bubbleRadius = 40; // Default is 40
        shareBubbles.showFacebookBubble = YES;
        shareBubbles.showTwitterBubble = YES;



        [shareBubbles show];
    }
}

-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType)
    {
        case AAShareBubbleTypeFacebook:
            
        {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [controller setInitialText:@"Fevue: Invite friend to your favourite festival"];
            [controller addURL:[NSURL URLWithString:@"http://deeplink.me/fevue.com"]];

            
            [self presentViewController:controller animated:YES completion:Nil];
            
            
            NSLog(@"Vkontakte (vk.com)");
        }
            
            break;
        case AAShareBubbleTypeTwitter:
        {
            
      
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"Fevue: Invite friend to your favourite festival"];
            [tweetSheet addURL:[NSURL URLWithString:@"http://deeplink.me/fevue.com/"]];

            
            [self presentViewController:tweetSheet animated:YES completion:nil];
            
            
            
        }
            
            
            break;
            
            
        //case AAShareBubbleTypeMail:
        {
        
        
        
        
        
        }
            [Flurry logEvent:@"Invite Friends -Pinterest Share "];
            NSLog(@"Vkontakte (vk.com)");
            break;
        default:
            break;
    }
}


-(void)aaShareBubblesDidHide:(AAShareBubbles*)bubbles {
    NSLog(@"All Bubbles hidden");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}






@end