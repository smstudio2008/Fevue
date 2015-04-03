//

#import "SKProgressIndicator.h"

/*static NSInteger kInnerCircleRadiusiPhone = 117;
 static NSInteger kInnerCircleRadiusiPad = 167;
 static NSInteger kInnnerCircleLineWidthiPhone = 22;
 static NSInteger kInnnerCircleLineWidthiPad = 22;
 
 static NSInteger kOuterCircleRadiusiPhone = 138;
 static NSInteger kOuterCircleRadiusiPad = 188;
 static CGFloat kOuterCircleLineWidthiPhone = 2.5;
 static CGFloat kOuterCircleLineWidthiPad = 2.5;*/

static NSString *kRotationAnimationKey = @"strokeEnd";
static NSString *kColorAnimationKey = @"strokeColor";

@interface SKProgressIndicator () {
    int innerCircleRadius,
    innerCircleLineWidth,
    outerCircleRadius,
    outerCircleLineWidth;
}


@property (nonatomic, weak) CAShapeLayer *outerCirclePathLayer;
@property (nonatomic, weak) CAGradientLayer *outerCircleGradientLayer;


@end

@implementation SKProgressIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupColors];
}

- (void)setupColors
{
    NSDictionary *colors = @{@"background"            : [UIColor colorWithRed:32.0/255.0 green:32.0/255.0 blue:32.0/255.0 alpha:0.0],
                             @"tint"                  : [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                             @"colorText"             : [UIColor colorWithRed:254.0/255.0 green:185.0/255.0 blue:52.0/255.0 alpha:1.0],
                             @"outerCircleProgress"   : [UIColor colorWithRed:241.0/255.0 green:176.0/255.0 blue:51.0/255.0 alpha:1.0],
                             @"outerCircleBackground" : [UIColor colorWithRed:82.0/255.0 green:82.0/255.0 blue:82.0/255.0 alpha:1.0],
                             @"innerCircleProgress"   : [UIColor colorWithRed:234.0/255.0 green:129.0/255.0 blue:37.0/255.0 alpha:1.0],
                             @"innerCircleBackground" : [UIColor colorWithRed:82.0/255.0 green:82.0/255.0 blue:82.0/255.0 alpha:1.0],
                             @"cellBackground"        : [UIColor colorWithRed:92.0/255.0 green:92.0/255.0 blue:92.0/255.0 alpha:1.0]};
    
    self.backgroundColor = [colors objectForKey:@"background"];
    self.innerCircleBackgroundColor = [colors objectForKey:@"innerCircleBackground"];
    self.innerCircleProgressColor = [colors objectForKey:@"innerCircleProgress"];
    self.outerCircleBackgroundColor = [colors objectForKey:@"outerCircleBackground"];
    self.outerCircleProgressColor = [colors objectForKey:@"outerCircleProgress"];
    self.textInsideCircleColor = [colors objectForKey:@"tint"];
}

- (void)drawRect:(CGRect)rect
{
    int side = MIN(rect.size.width, rect.size.height);
    
    outerCircleRadius = side / 2.1 - outerCircleLineWidth;
    outerCircleLineWidth = 2;
    innerCircleLineWidth = side / 13;
    innerCircleRadius = outerCircleRadius - outerCircleLineWidth - innerCircleLineWidth;
    
    // Draw circles
    [self drawInnerCircleBackgroundIn:rect];
    [self drawInnerCircleProgress:self.percentInnerCircle inRect:rect];
    [self drawOuterCircleBackgroundIn:rect];
    [self drawOuterCircleProgress:self.percentInnerCircle inRect:rect];
}

#pragma mark - Draw Circles

- (void)drawInnerCircleBackgroundIn:(CGRect)rect
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter: CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius: innerCircleRadius
                      startAngle: 0
                        endAngle: M_PI * 2
                       clockwise: YES];
    
    bezierPath.lineWidth = innerCircleLineWidth;
    [self.innerCircleBackgroundColor setStroke];
    [bezierPath stroke];
}

- (void)drawInnerCircleProgress:(CGFloat)percent inRect:(CGRect)rect
{
    CGFloat startAngle = M_PI * 1.5;
    CGFloat endAngle = startAngle + (M_PI * 2);
    
    if (percent > 100) {
        percent = 100;
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter: CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius: innerCircleRadius
                      startAngle: startAngle
                        endAngle: (endAngle - startAngle) * (percent / 100.0) + startAngle
                       clockwise: YES];
    
    bezierPath.lineWidth = innerCircleLineWidth;
    [self.innerCircleProgressColor setStroke];
    [bezierPath stroke];
}

- (void)drawOuterCircleBackgroundIn:(CGRect)rect
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter: CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius: outerCircleRadius
                      startAngle: 0
                        endAngle: M_PI * 2
                       clockwise: YES];
    bezierPath.lineWidth = outerCircleLineWidth;
    [self.outerCircleBackgroundColor setStroke];
    [bezierPath stroke];
}

- (void)drawOuterCircleProgress:(CGFloat)percent inRect:(CGRect)rect
{
    if (percent >= 100) {
        [self doneOuterCircleAnimation];
    } else {
        [self progressOuterCircleAnimation];
    }
}

- (void)progressOuterCircleAnimation
{
    // If the shape layer doesn't exist, create it
    if (self.outerCirclePathLayer == nil) {
        
        // Create path
        CGFloat startAngle = M_PI * 1.5;
        CGFloat endAngle = startAngle + (M_PI * 2);
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath addArcWithCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                              radius: outerCircleRadius
                          startAngle: startAngle
                            endAngle: endAngle
                           clockwise: YES];
        
        // Shape layer setup
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        shapeLayer.strokeColor = self.outerCircleProgressColor.CGColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = outerCircleLineWidth;
        shapeLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:shapeLayer];
        self.outerCirclePathLayer = shapeLayer;
    }
    
    if (self.outerCircleGradientLayer.superlayer == nil) {
        
        [self.outerCirclePathLayer removeAllAnimations];
        
        // Gradient layer
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[(__bridge id)self.outerCircleProgressColor.CGColor,
                                 (__bridge id)self.innerCircleBackgroundColor.CGColor,
                                 (__bridge id)self.innerCircleBackgroundColor.CGColor,
                                 (__bridge id)self.innerCircleBackgroundColor.CGColor];
        gradientLayer.startPoint = CGPointMake(0,0.5);
        gradientLayer.endPoint = CGPointMake(1,0.5);
        [self.layer addSublayer:gradientLayer];
        gradientLayer.mask = self.outerCirclePathLayer;
        self.outerCircleGradientLayer = gradientLayer;
        
        // Animation
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotateAnimation.duration = 1.2;
        rotateAnimation.repeatCount = INFINITY;
        rotateAnimation.fromValue = @(0.0f);
        rotateAnimation.toValue = @((360*M_PI)/180);
        rotateAnimation.removedOnCompletion = NO;
        
        [gradientLayer addAnimation:rotateAnimation forKey:@"transform.rotation"];
    }
}

- (void)doneOuterCircleAnimation
{
    if (self.outerCirclePathLayer == nil) {
        CGFloat startAngle = M_PI * 1.5;
        CGFloat endAngle = startAngle + (M_PI * 2);
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath addArcWithCenter: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                              radius: outerCircleRadius
                          startAngle: startAngle
                            endAngle: endAngle
                           clockwise: YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        shapeLayer.strokeColor = self.outerCircleProgressColor.CGColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = outerCircleLineWidth;
        shapeLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:shapeLayer];
        self.outerCirclePathLayer = shapeLayer;
    }
    
    if ([self.outerCirclePathLayer animationForKey:kColorAnimationKey] == nil) {
        
        [self.outerCirclePathLayer removeAllAnimations];
        [self.outerCircleGradientLayer removeFromSuperlayer];
        
        // Add new animation
        CGFloat duration = 1.5;
        CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:kColorAnimationKey];
        strokeAnimation.duration = duration;
        strokeAnimation.repeatCount = INFINITY;
        strokeAnimation.autoreverses = YES;
        strokeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        strokeAnimation.fromValue = (id)self.outerCircleProgressColor.CGColor;
        strokeAnimation.toValue = (id)self.outerCircleBackgroundColor.CGColor;
        strokeAnimation.removedOnCompletion = NO;
        
        [self.outerCirclePathLayer addAnimation:strokeAnimation forKey:kColorAnimationKey];
    }
}

@end

