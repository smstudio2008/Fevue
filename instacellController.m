//
//  instacellController.m
//  fevue
//
//  Created by SALEM on 24/11/2014.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "instacellController.h"
#import "SBInstagramImageViewController.h"
#import "instaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "instaViewimageController.h"

@implementation instacellController

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
    }
    return self;
}


-(void)setEntity:(SBInstagramMediaPagingEntity *)entity andIndexPath:(NSIndexPath *)index{
    
    [self setupCell];
    
    [self.imageButton setBackgroundImage:[UIImage imageNamed:[SBInstagramModel model].loadingImageName] forState:UIControlStateNormal];
    _entity = entity;
    
    SBInstagramImageEntity *imgEntity = entity.mediaEntity.images[@"standard_resolution"];
    if (imgEntity.width <= CGRectGetWidth(self.imageButton.frame)) {
        imgEntity = entity.mediaEntity.images[@"standard_resolution"];
    }
    
    if (imgEntity.width <= CGRectGetWidth(self.imageButton.frame)) {
        imgEntity = entity.mediaEntity.images[@"standard_resolution"];
    }
    
    [imgEntity downloadImageWithBlock:^(UIImage *image, NSError *error) {
        if (self.indexPath.row == index.row) {
            [self.imageButton setBackgroundImage:image forState:UIControlStateNormal];
        }
    }];
    
    self.imageButton.userInteractionEnabled = !self.showOnePicturePerRow;
    self.imageButton.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    
    if (self.showOnePicturePerRow) {
        
        self.userLabel.text = self.entity.mediaEntity.userName;
        [self.contentView addSubview:self.userLabel];
        
        self.captionLabel.text = self.entity.mediaEntity.caption;
        [self.contentView addSubview:self.captionLabel];
        
        [self.userImage setImage:[UIImage imageNamed:[SBInstagramModel model].loadingImageName]];
        [self.contentView addSubview:self.userImage];
        
        [SBInstagramModel downloadImageWithUrl:self.entity.mediaEntity.profilePicture andBlock:^(UIImage *image2, NSError *error) {
            if (image2 && !error && self.indexPath.row == index.row) {
                [self.userImage setImage:image2];
            }
        }];
        
        
        self.videoPlayImage.frame = CGRectMake(60, 70, 200, 200);
    }else{
        [self.userLabel removeFromSuperview];
        [self.userImage removeFromSuperview];
        [self.captionLabel removeFromSuperview];
        
        self.videoPlayImage.frame = CGRectMake(35, 30, 100, 100);
        
    }
    
    self.videoPlayImage.hidden = YES;
    if (self.avPlayerLayer) {
        [self.avPlayerLayer removeFromSuperlayer];
    }
    if (entity.mediaEntity.type == SBInstagramMediaTypeVideo) {
        self.videoPlayImage.hidden = NO;
        
        if (self.showOnePicturePerRow) {
            NSString *url = ((SBInstagramVideoEntity *) entity.mediaEntity.videos[@"low_resolution"]).url;
            if ([SBInstagramModel model].playStandardResolution) {
                url = ((SBInstagramVideoEntity *) entity.mediaEntity.videos[@"standard_resolution"]).url;
            }
            AVAsset* avAsset = [AVAsset assetWithURL:[NSURL URLWithString:url]];
            self.avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
            
            if (!self.avPlayer) {
                self.avPlayer = [[AVPlayer alloc]initWithPlayerItem: self.avPlayerItem];
            }else{
                [self.avPlayer replaceCurrentItemWithPlayerItem: nil];
                [self.avPlayer replaceCurrentItemWithPlayerItem: self.avPlayerItem];
            }
            
            if (!self.avPlayerLayer) {
                self.avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
            }
            
            [self.avPlayerLayer setFrame:self.imageButton.frame];
            [self.imageButton.superview.layer insertSublayer:self.avPlayerLayer above:self.imageButton.layer];
            [self.avPlayer seekToTime:kCMTimeZero];
            
            // MARK
            self.playerStatusTimer = [NSTimer scheduledTimerWithTimeInterval: 0.2 target: self selector: @selector(checkStatus) userInfo: nil repeats: YES];
            //[avPlayerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
            
            [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
            self.imageButton.userInteractionEnabled = YES;
            
            if (self.videoControlBlock) {
                self.videoControlBlock(self.avPlayer,NO,self.videoPlayImage);
            }
            
            self.loadComplete = NO;
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playerItemDidReachEnd:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:nil];
            
            
        }else{
            if (self.avPlayerLayer) {
                [self.avPlayerLayer removeFromSuperlayer];
            }
        }
        
    }
    
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    if ([self.avPlayer currentItem] == [notification object]) {
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
    }
}


-(void) playerItemPlay:(NSNotification *)notification {
    if ([self.avPlayer currentItem] == [notification object]) {
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPauseImageName]];
    }
}


- (void)checkStatus
{
    switch(self.avPlayerItem.status)
    {
        case AVPlayerItemStatusFailed:
            //                    NSLog(@"player item status failed");
            if (_timer) {
                [_timer invalidate];
            }
            
            if (self.playerStatusTimer) {
                [self.playerStatusTimer invalidate];
                self.playerStatusTimer = nil;
            }
            
            break;
        case AVPlayerItemStatusReadyToPlay:
            if (_timer) {
                [_timer invalidate];
            }
            
            if (self.playerStatusTimer) {
                [self.playerStatusTimer invalidate];
                self.playerStatusTimer = nil;
            }
            
            self.loadComplete = YES;
            self.videoPlayImage.hidden = NO;
            //                    NSLog(@"player item status is ready to play");
            break;
        case AVPlayerItemStatusUnknown:
            //                    NSLog(@"player item status is unknown");
            break;
    }
}


- (void) loadingVideo{
    self.videoPlayImage.hidden = !self.videoPlayImage.hidden;
}

-(void) removeNoti{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) playVideo:(NSString *)url{
    if (self.showOnePicturePerRow) {
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
        
        [self.avPlayerLayer setFrame:self.imageButton.frame];
        [self.imageButton.superview.layer insertSublayer:self.avPlayerLayer above:self.imageButton.layer];
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.avPlayer play];
        [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
        self.imageButton.userInteractionEnabled = YES;
    }
}

-(void) selectedImage:(id)selector{
    
    if (self.entity.mediaEntity.type == SBInstagramMediaTypeVideo && self.showOnePicturePerRow) {
        
        if (self.avPlayer.rate == 0) {
            if (CMTimeCompare(self.avPlayer.currentItem.currentTime, self.avPlayer.currentItem.duration) == 0) {
                [self.avPlayer seekToTime:kCMTimeZero];
            }
            [self.avPlayer play];
            [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPauseImageName]];
            
            if (!_loadComplete) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(loadingVideo) userInfo:nil repeats:YES];
            }
            
            if (self.videoControlBlock) {
                self.videoControlBlock(self.avPlayer,YES,self.videoPlayImage);
            }
            
        }else{
            [self.avPlayer pause];
            [self.videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
        }
        
        
        
        return;
    }
    
    // MARK
    /*UIViewController *viewCon = (UIViewController *)self.nextResponder;
     
     while (![viewCon isKindOfClass:[UINavigationController class]]) {
     viewCon = (UIViewController *)viewCon.nextResponder;
     }
     
     SBInstagramImageViewController *img = [SBInstagramImageViewController imageViewerWithEntity:self.entity.mediaEntity];
     
     [((UINavigationController *)viewCon) pushViewController:img animated:YES];*/
    
    UIViewController *viewCon = (UIViewController *)self.nextResponder;
    
    while (![viewCon isKindOfClass:[instaViewController class]]) {
        viewCon = (UIViewController *)viewCon.nextResponder;
    }
    
    instaViewimageController*imageViewController = [instaViewimageController imageViewerWithEntity:self.entity.mediaEntity];
    
    [((instaViewController*)viewCon) showContentController: imageViewController];
}

- (void) setupCell{
    
    
    if (!_imageButton) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_imageButton setFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.width)];
    [_imageButton addTarget:self action:@selector(selectedImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageButton setBackgroundImage:[UIImage imageNamed:[SBInstagramModel model].loadingImageName] forState:UIControlStateNormal];
    self.imageButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageButton];
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
    }
    _userLabel.frame = CGRectMake(35, 287, 200, 35);
    _userLabel.textColor = [UIColor whiteColor];
    _userLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:13];
    
    if (!_captionLabel) {
        _captionLabel = [[UILabel alloc] init];
    }
    
    _captionLabel.frame = CGRectMake(300, 270, CGRectGetWidth(self.frame) - 100, 50);
    _captionLabel.numberOfLines = 2;
    _captionLabel.textColor = [UIColor whiteColor];
    _captionLabel.font =[UIFont fontWithName:@"Avenir-Book" size:12];
    
    if (!_userImage) {
        _userImage = [[UIImageView alloc] init];
    }
    _userImage.frame = CGRectMake(5, 292, 24, 24);
    _userImage.contentMode = UIViewContentModeScaleAspectFit;
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = 12;
    
    if (!_videoPlayImage) {
        _videoPlayImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    [_videoPlayImage setImage:[UIImage imageNamed:[SBInstagramModel model].videoPlayImageName]];
    [self.contentView addSubview:_videoPlayImage];
    
    
}


@end
