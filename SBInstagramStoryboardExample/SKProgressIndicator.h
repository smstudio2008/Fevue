#import <UIKit/UIKit.h>

@interface SKProgressIndicator : UIView

@property (assign, nonatomic) CGFloat percentInnerCircle;
@property (assign, nonatomic) CGFloat percentOuterCircle;

@property (strong, nonatomic) UIColor *innerCircleBackgroundColor;
@property (strong, nonatomic) UIColor *innerCircleProgressColor;
@property (strong, nonatomic) UIColor *outerCircleBackgroundColor;
@property (strong, nonatomic) UIColor *outerCircleProgressColor;
@property (strong, nonatomic) UIColor *textInsideCircleColor;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *metaLabel;

@end
