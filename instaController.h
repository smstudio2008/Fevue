//
//  instaController.h
//  fevue
//
//  Created by SALEM on 24/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "instaViewController.h"
@class SBInstagramMediaPagingEntity;

static NSString *const INSTAGRAM_API_VERSION = @"1";

//client information (from www.instagram.com/developer)
static NSString *const INSTAGRAM_REDIRECT_URI = @"";
static NSString *const INSTAGRAM_CLIENT_SECRET = @"";
static NSString *const INSTAGRAM_CLIENT_ID  = @"";

//if this value is empty or expired or not valid, automatically request a new one. (if you set nil the app crash)
static NSString *const INSTAGRAM_USER_ID  = @""; //user id to requests

@interface instaController : NSObject

@property (nonatomic, assign) UIViewController *viewController;
@property (nonatomic, assign) BOOL isSearchByTag;
@property (nonatomic, strong) NSString *searchTag;
@property (nonatomic, strong) instaViewController *instagramCollection;

//mapping variables v2
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, assign) BOOL showSwitchModeView;
@property (nonatomic, readonly) UIViewController *feed;
@property (nonatomic, assign) BOOL showOnePicturePerRow;


//Setup variables v2
@property (nonatomic, strong) NSString *instagramRedirectUri;
@property (nonatomic, strong) NSString *instagramClientSecret;
@property (nonatomic, strong) NSString *instagramClientId;
@property (nonatomic, strong) NSArray *instagramMultipleDefaultAccessToken;
@property (nonatomic, strong) NSString *instagramUserId;
@property (nonatomic, strong) NSString *loadingImageName; //if you need set your oun loading image
@property (nonatomic, strong) NSString *videoPlayImageName; //if you need set your oun play video image
@property (nonatomic, strong) NSString *videoPauseImageName; //if you need set your oun pause video image
@property (nonatomic, assign) BOOL playStandardResolution; //if you want play a regular resuluton, low resolution per default
@property (nonatomic, strong) NSArray *instagramMultipleUsersId;
@property (nonatomic, strong) NSArray *instagramMultipleTags;


+ (instaViewController *) instagramViewController;
+ (id) instagramControllerWithMainViewController:(UIViewController *) viewController;
- (NSString *) AccessToken;
- (void) mediaUserWithUserId:(NSString *)userId andBlock:(void (^)(NSArray *mediaArray, NSError * error))block;
- (void) mediaUserWithPagingEntity:(SBInstagramMediaPagingEntity *)entity andBlock:(void (^)(NSArray *mediaArray, NSError * error))block;
- (void) mediaMultipleUserWithArr:(NSArray *)usersId complete:(void (^)(NSArray *mediaArray,NSArray *lastMedia, NSError * error))block;
- (void) mediaMultiplePagingWithArr:(NSArray *)entites complete:(void (^)(NSArray *mediaArray,NSArray *lastMedia, NSError * error))block;
//mapped
-(void) refreshCollection2;

//v2
+ (instaController *) instagram;

@end
