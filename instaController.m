//
//  instaController.m
//  fevue
//
//  Created by SALEM on 24/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import "instaController.h"
#import "SBInstagramModel.h"
#import "SBInstagramWebViewController.h"
#import "instaViewController.h"

@implementation instaController


// this is only for support the v1 of the SBInstagram
+ (instaViewController  *) instagramViewController{
    
    return [[instaViewController  alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
}

//v2 initiallization
+ (instaController *) instagram{
    
    instaController *instance = [instaController new];
    
    instance.instagramCollection = [[instaViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    
    return instance;
}


+ (id) instagramControllerWithMainViewController:(UIViewController *) viewController {
    instaController*instance = [[instaController alloc] init];
    instance.viewController = viewController;
    return instance;
}




- (NSString *) AccessToken{
    
    NSString *token = [SBInstagramModel model].instagramMultipleDefaultAccessToken[[SBInstagramModel model].instagramAccessTokenIndex];
    
    return token;
}


-(void) validateTokenWithBlock:(void (^)(NSError *error))block{
    
    [SBInstagramModel checkInstagramAccesTokenWithBlock:^(NSError *error) {
        block(nil);
        //        if (error.code == InstagramAccessTokenErrorCode) {
        //            [self renewAccessTokenWithBlock:block];
        //        }else{
        //            block(nil);
        //        }
    }];
}


- (void) renewAccessTokenWithBlock:(void (^)(NSError *error))block{
    __weak typeof(self) weakSelf = self;
    double delayInSeconds = 1.0;
    
    NSString *clientId = [SBInstagramModel model].instagramClientId ?: INSTAGRAM_CLIENT_ID;
    NSString *redirectUrl = [SBInstagramModel model].instagramRedirectUri ?: INSTAGRAM_REDIRECT_URI;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString *urlString = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token",clientId,redirectUrl];
        
        SBInstagramWebViewController *viewCon = [SBInstagramWebViewController webViewWithUrl:urlString andSuccessBlock:^(NSString *token, UIViewController *viewController) {
            NSLog(@"your new access token is: %@",token);
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:token forKey:@"instagram_access_token"];
            [def synchronize];
            [viewController dismissViewControllerAnimated:YES completion:^{
                block(nil);
            }];
        }];
        
        [viewCon setModalPresentationStyle:UIModalPresentationPageSheet];
        [viewCon setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [weakSelf.viewController presentViewController:viewCon animated:YES completion:nil];
        
    });
}

- (void) mediaUserWithUserId:(NSString *)userId andBlock:(void (^)(NSArray *mediaArray, NSError * error))block{
    
    [self validateTokenWithBlock:^(NSError *error) {
        if (!error) {
            [SBInstagramModel mediaUserWithUserId:userId andBlock:block];
        }
    }];
    
}

- (void) mediaMultipleUserWithArr:(NSArray *)usersId complete:(void (^)(NSArray *mediaArray,NSArray *lastMedia, NSError * error))block{
    
    [self validateTokenWithBlock:^(NSError *error) {
        if (!error) {
            [SBInstagramModel mediaMultipleUsersWithArr:usersId complete:block];
        }
    }];
    
}


- (void) mediaUserWithPagingEntity:(SBInstagramMediaPagingEntity *)entity andBlock:(void (^)(NSArray *mediaArray, NSError * error))block{
    
    [self validateTokenWithBlock:^(NSError *error) {
        if (!error) {
            [SBInstagramModel mediaUserWithPagingEntity:entity andBlock:block];
        }
    }];
    
}


- (void) mediaMultiplePagingWithArr:(NSArray *)entites complete:(void (^)(NSArray *mediaArray,NSArray *lastMedia, NSError * error))block{
    
    [self validateTokenWithBlock:^(NSError *error) {
        if (!error) {
            [SBInstagramModel mediaMultiplePagingWithArr:entites complete:block];
        }
    }];
    
}


#pragma mark - v2
//mapping variables

-(NSString *)version{
    return _instagramCollection.version;
}

-(void) setShowSwitchModeView:(BOOL)showSwitchModeView{
    _instagramCollection.showSwitchModeView = showSwitchModeView;
}

-(BOOL) showSwitchModeView{
    return _instagramCollection.showSwitchModeView;
}

- (void) setIsSearchByTag:(BOOL)isSearchByTag{
    SBInstagramModel.isSearchByTag = isSearchByTag;
    _instagramCollection.isSearchByTag = isSearchByTag;
}

-(BOOL) isSearchByTag{
    return _instagramCollection.isSearchByTag;
}

- (void) setSearchTag:(NSString *)searchTag{
    SBInstagramModel.searchTag = searchTag;
    _instagramCollection.searchTag = searchTag;
}

- (NSString *) searchTag{
    return _instagramCollection.searchTag;
}

-(UIViewController *) feed{
    return _instagramCollection;
}

-(void) refreshCollection2{
    [_instagramCollection refreshCollection2];
}

- (void) setShowOnePicturePerRow:(BOOL)showOnePicturePerRow{
    _instagramCollection.showOnePicturePerRow = showOnePicturePerRow;
}

- (BOOL) showOnePicturePerRow{
    return _instagramCollection.showOnePicturePerRow;
}



//setup v2
- (void) setInstagramRedirectUri:(NSString *)instagramRedirectUri{
    [SBInstagramModel model].instagramRedirectUri = instagramRedirectUri;
}
- (void) setInstagramClientSecret:(NSString *)instagramClientSecret{
    [SBInstagramModel model].instagramClientSecret = instagramClientSecret;
}
- (void) setInstagramClientId:(NSString *)instagramClientId{
    [SBInstagramModel model].instagramClientId = instagramClientId;
}
- (void) setInstagramMultipleDefaultAccessToken:(NSArray *)instagramMultipleDefaultAccessToken{
    [SBInstagramModel model].instagramMultipleDefaultAccessToken = instagramMultipleDefaultAccessToken;
}
- (void) setInstagramUserId:(NSString *)instagramUserId{
    [SBInstagramModel model].instagramUserId = instagramUserId;
}
-(void) setLoadingImageName:(NSString *)loadingImageName{
    [SBInstagramModel model].loadingImageName = loadingImageName;
}
-(void) setVideoPlayImageName:(NSString *)videoPlayImageName{
    [SBInstagramModel model].videoPlayImageName = videoPlayImageName;
}
-(void) setVideoPauseImageName:(NSString *)videoPauseImageName{
    [SBInstagramModel model].videoPauseImageName = videoPauseImageName;
}
-(void) setplayStandardResolution:(BOOL)playStandardResolution{
    [SBInstagramModel model].playStandardResolution = playStandardResolution;
}
-(void) setInstagramMultipleUsersId:(NSArray *)instagramMultipleUsersId{
    [SBInstagramModel model].instagramMultipleUsersId = instagramMultipleUsersId;
}
-(void) setInstagramMultipleTags:(NSArray *)instagramMultipleTags{
    if (instagramMultipleTags) {
        [self setIsSearchByTag:YES];
    }
    [SBInstagramModel model].instagramMultipleUsersId = instagramMultipleTags;
}


- (NSString *) instagramRedirectUri{
    return [SBInstagramModel model].instagramRedirectUri;
}
- (NSString *) instagramClientSecret{
    return [SBInstagramModel model].instagramClientSecret;
}
- (NSString *) instagramClientId{
    return [SBInstagramModel model].instagramClientId;
}
- (NSArray *) instagramMultipleDefaultAccessToken{
    return [SBInstagramModel model].instagramMultipleDefaultAccessToken;
}
- (NSString *) instagramUserId{
    return [SBInstagramModel model].instagramUserId;
}
- (NSString *) loadingImageName{
    return [SBInstagramModel model].loadingImageName;
}
- (NSString *) videoPlayImageName{
    return [SBInstagramModel model].videoPlayImageName;
}
- (NSString *) videoPauseImageName{
    return [SBInstagramModel model].videoPauseImageName;
}
- (BOOL) playStandardResolution{
    return [SBInstagramModel model].playStandardResolution;
}
- (NSArray *) instagramMultipleUsersId{
    return [SBInstagramModel model].instagramMultipleUsersId;
}
- (NSArray *) instagramMultipleTags{
    return [SBInstagramModel model].instagramMultipleUsersId;
}

@end
