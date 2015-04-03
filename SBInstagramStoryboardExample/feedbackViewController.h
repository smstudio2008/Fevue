//
//  feedbackViewController.h
//  fevue
//
//  Created by SALEM on 08/12/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface feedbackViewController : UIViewController{
    CGFloat _imageHeaderHeight;
}

@property (nonatomic) BOOL isPresented;
@property(nonatomic,strong) UIImageView *imgView;
@end
