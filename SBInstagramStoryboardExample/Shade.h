//
//  Shade.h
//  Shade
//
//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Shade : UILabel

@property CGFloat   shadeOpacity;
@property CGSize    shadeOffset;
@property UIColor   *shadeColor;
@property CGFloat   shadeRadius;

- (void)update;
@end
