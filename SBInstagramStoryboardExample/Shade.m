//
//  Shade.m
//  Shade
//
//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import "Shade.h"

@implementation Shade

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.shadowColor = [UIColor blackColor];
    self.shadowOffset = CGSizeZero;
    self.shadeRadius = 5;
    self.shadeOpacity = 0.7f;
}

- (UIColor *)colorOfPoint:(CGPoint)point{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.superview.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0
                                     green:pixel[1]/255.0
                                      blue:pixel[2]/255.0
                                     alpha:pixel[3]/255.0];
    
    return color;
}

- (BOOL)shadeBackgroundIsBright {
    const CGFloat *componentColors = CGColorGetComponents([self colorOfPoint:self.frame.origin].CGColor);
    CGFloat darknessScore = (((componentColors[0]*255) * 299) + ((componentColors[1]*255) * 587) + ((componentColors[2]*255) * 114)) / 1000;
    if (darknessScore >= 125) {
        return YES;
    }
    return NO;
}

- (void)update {
    if ([self shadeBackgroundIsBright]) {
        self.layer.shadowOpacity = _shadeOpacity;
        self.layer.shadowColor = _shadeColor.CGColor;
        self.layer.shadowRadius = _shadeRadius;
        self.layer.shadowOffset = _shadeOffset;
    }
    else {
        self.layer.shadowOpacity = 0;
    }
}

@end
