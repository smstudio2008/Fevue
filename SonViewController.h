//
//  SonViewController.h
//  fevue
//
//  Created by SALEM on 27/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
@interface SonViewController : UIViewController{
    CGFloat _imageHeaderHeight;
}

@property (nonatomic) BOOL isPresented;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *imgView1;
@end
