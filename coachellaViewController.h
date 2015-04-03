//
//  coachellaViewController.h
//  fevue
//
//  Created by SALEM on 26/02/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface  coachellaViewController : UIViewController{
    CGFloat _imageHeaderHeight;
}

@property (nonatomic) BOOL isPresented;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *imgView1;
@end

