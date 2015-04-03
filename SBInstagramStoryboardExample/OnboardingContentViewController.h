//
//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface OnboardingContentViewController : UIViewController {
    NSString *_titleText;
    NSString *_body;
    UIImage *_image;
    NSString *_buttonText;
    dispatch_block_t _actionHandler;
    NSString *_moviePath;
}

@property (nonatomic) CGFloat iconSize;

@property (nonatomic, retain) UIColor *titleTextColor;
@property (nonatomic, retain) UIColor *bodyTextColor;
@property (nonatomic, retain) UIColor *buttonTextColor;

@property (nonatomic, retain) NSString *fontName;
@property (nonatomic) CGFloat titleFontSize;
@property (nonatomic) CGFloat bodyFontSize;

@property (nonatomic) CGFloat topPadding;
@property (nonatomic) CGFloat underIconPadding;
@property (nonatomic) CGFloat underTitlePadding;
@property (nonatomic) CGFloat bottomPadding;

- (id)initWithTitle:(NSString *)title body:(NSString *)body videoName:(NSString *)vName buttonText:(NSString *)buttonText action:(dispatch_block_t)action;

@end
