//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
@interface creamViewController : UIViewController{
    CGFloat _imageHeaderHeight;
}

@property (nonatomic) BOOL isPresented;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *imgView1;
@end
