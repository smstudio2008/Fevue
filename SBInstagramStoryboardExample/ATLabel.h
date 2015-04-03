//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import <UIKit/UIKit.h>


/**
 `ATAnimationType` is a list of animaton type.
 */
enum {
    ATAnimationTypeFadeInOut = 1,
    ATAnimationTypeSlideLeftInLeftOut = 2,
    ATAnimationTypeSlideRightInRightOut = 3,
    ATAnimationTypeSlideTopInTopOut = 4,
    ATAnimationTypeSlideBottomtInBottomOut = 5,
    ATAnimationTypeSlideLeftInRightOut = 6,
    ATAnimationTypeSlideRightInLeftOut = 7,
    ATAnimationTypeSlideBottomInTopOut = 8,
    ATAnimationTypeSlideTopInBottomOut = 9
};
typedef NSUInteger ATAnimationType;

/**
 `ATLabel` provides an interface to change words in an animated way.
 */
@interface ATLabel : UILabel

/**
 `wordList` is the list of words that has to be shuffled.
 */
@property(nonatomic, retain) NSArray *wordList;

/**
 `duration` duration of the animation.
 */
@property(nonatomic, assign) double duration;

/**
 `ATAnimationType` for animation of the text.
 */
@property(nonatomic, assign) ATAnimationType animationType;

///---------------------------
/// @name Animating function for the label's extension.
///---------------------------

/**
 *  Animate the words from the list
 *
 *  @param words list of words.
 *  @param time  total duration of the animation between each switch.
 */
- (void)animateWithWords:(NSArray *)words forDuration:(double)time;

/**
 *  Animation with the type of animation type.
 *
 *  @param words     list of words.
 *  @param time      total duration of the animation between each switch.
 *  @param animation type of animation
 */
- (void)animateWithWords:(NSArray *)words forDuration:(double)time withAnimation:(ATAnimationType)animation;

@end
