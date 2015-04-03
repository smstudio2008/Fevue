//
//  secreticViewController.h
//  fevue
//
//  Created by SALEM on 28/01/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTGlassScrollView.h"
#import "VBFPopFlatButton.h"
#import "HTPressableButton.h"
#import "UIColor+HTColor.h"
#import "JBWebViewController.h"

@interface   secreticViewController : UIViewController <UIScrollViewAccessibilityDelegate>

@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property (nonatomic, strong) UILabel * bestivalLabel;
@property (nonatomic, strong) UILabel * bestivalLabel1;
@property (nonatomic, strong) UILabel * tickets;
@property (nonatomic, strong) UILabel * tickets1;
@property (nonatomic, strong) UILabel * price;
@property (nonatomic, strong) UILabel * price1;
@property (nonatomic, strong) UILabel * price2;
@property (nonatomic, strong) UILabel * price3;

@end
