//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import "ATLabel.h"

@implementation ATLabel
@synthesize wordList = _wordList;
@synthesize duration = _duration;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)animateWithWords:(NSArray *)words forDuration:(double)time {

  [self animateWithWords:words
             forDuration:time
           withAnimation:ATAnimationTypeFadeInOut];
}

- (void)animateWithWords:(NSArray *)words
             forDuration:(double)time
           withAnimation:(ATAnimationType)animation {

  self.duration = time;
  if (self.wordList) {
    self.wordList = nil;
  }
  self.animationType = animation;
  self.wordList = [[NSArray alloc] initWithArray:words];
  self.text = [self.wordList objectAtIndex:0];
  [NSThread detachNewThreadSelector:@selector(_startAnimations:)
                           toTarget:self
                         withObject:self.wordList];
}

- (void)_startAnimations:(NSArray *)images {

  @autoreleasepool {

    for (uint i = 1; i < [images count]; i++) {
      sleep(self.duration);
      [self performSelectorOnMainThread:@selector(_animate:)
                             withObject:[NSNumber numberWithInt:i]
                          waitUntilDone:YES];

      sleep(self.duration);
      if (i == [images count] - 1) {
        i = -1;
      }
    }
  }
}

- (void)_animate:(NSNumber *)num {

  CGRect __block originalSize;
  if (self.animationType == ATAnimationTypeFadeInOut) {
    [UIView animateWithDuration:self.duration / 2
        animations:^{ self.alpha = 0.0; }
        completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration / 2
                animations:^{
                    self.alpha = 1.0;
                    self.text = [self.wordList objectAtIndex:[num intValue]];
                }
                completion:^(BOOL finished) {}];
        }];

  } else {

    [UIView animateWithDuration:self.duration / 2
        animations:^{

            self.alpha = 0.0;

            CGRect fullSize = self.frame;
            originalSize = self.frame;

            switch (self.animationType) {
                case ATAnimationTypeSlideTopInTopOut:
                    fullSize.origin.y -= fullSize.size.height/4;
                    break;
                case ATAnimationTypeSlideBottomtInBottomOut:
                    fullSize.origin.y += fullSize.size.height/4;
                    break;
                case ATAnimationTypeSlideTopInBottomOut:
                    fullSize.origin.y += originalSize.size.width/4;
                    break;
                case ATAnimationTypeSlideBottomInTopOut:
                    fullSize.origin.y -= originalSize.size.width/4;
                    break;
                case ATAnimationTypeSlideLeftInLeftOut:
                    fullSize.origin.x -= originalSize.size.width/2;
                    break;
                case ATAnimationTypeSlideRightInRightOut:
                    fullSize.origin.x += originalSize.size.width/2;
                    break;
                case ATAnimationTypeSlideLeftInRightOut:
                    fullSize.origin.x += originalSize.size.width/2;
                    break;
                case ATAnimationTypeSlideRightInLeftOut:
                    fullSize.origin.x -= originalSize.size.width/2;
                    break;
                default:
                    break;
            }
            
            self.frame = fullSize;
        }
        completion:^(BOOL finished) {
            
            CGRect fullSize = self.frame;
            switch (self.animationType) {
                case ATAnimationTypeSlideTopInTopOut:
                    
                    break;
                case ATAnimationTypeSlideBottomtInBottomOut:
                    
                    break;
                case ATAnimationTypeSlideTopInBottomOut:
                    fullSize.origin.y = originalSize.origin.y;
                    fullSize.origin.y -= originalSize.size.height/4;
                    break;
                case ATAnimationTypeSlideBottomInTopOut:
                    fullSize.origin.y = originalSize.origin.y;
                    fullSize.origin.y += originalSize.size.height/4;

                    break;
                case ATAnimationTypeSlideLeftInLeftOut:
                    
                    break;
                case ATAnimationTypeSlideRightInRightOut:
                    
                    break;
                case ATAnimationTypeSlideLeftInRightOut:
                    fullSize.origin.x -= 2 * originalSize.size.width/4;
                    break;
                case ATAnimationTypeSlideRightInLeftOut:
                    fullSize.origin.x += 2 * originalSize.size.width/4;
                    break;
                default:
                    break;
            }
            self.frame = fullSize;
            
            [UIView animateWithDuration:self.duration / 2
                animations:^{

                    self.alpha = 1.0;
                    CGRect fullSize = self.frame;
                    fullSize = originalSize;
                    self.frame = fullSize;
                    self.text = [self.wordList objectAtIndex:[num intValue]];
                }
                completion:^(BOOL finished) {}];
        }];
  }
}

@end