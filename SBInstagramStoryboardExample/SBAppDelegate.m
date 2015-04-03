//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "SBAppDelegate.h"
#import "SBInstagramController.h"
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"
#import "PHMenuViewController.h"
#import <Parse/Parse.h>
#import "SettingsViewController.h"
#import "MYViewController.h"
#import "feedbackViewController.h"
#import "Flurry.h"
#import "SCLAlertView.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <ParseCrashReporting/ParseCrashReporting.h>
#import  <GoogleMaps/GoogleMaps.h>

@implementation SBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //  [Parse enableLocalDatastore];
    [ParseCrashReporting enable];
    [Parse setApplicationId:@"iAooB1QK2MeepDEYRtCjPaBxPBiXJ5hmhUQsQFi0"
                  clientKey:@"kWHEeFnl1qDqIJM5vATO3iRWgzU0tQ2kbSFahzzV"];
    

    [Flurry startSession:@"DY36H7ZBQ5MBZHG4DWJY"];

    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey: @"Lq7myydCmXyIjlMbuDruWoEI4" consumerSecret: @"8Nb6hsmbegZdCjttYoNLbtyJzxsDmcgZKHKkUiHlsTZWR81xw2"];

    [GMSServices provideAPIKey:@"AIzaSyBEHVrj0bgT8DkC4peH_TJwDK1LVlYjH6E"];
    
    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    UIViewController *mainController = [[UIViewController alloc] init];
    mainController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController: mainController];
    self.navigationController.navigationBarHidden = YES;
    
    UINavigationController *diceViewController = [[UINavigationController alloc] initWithRootViewController:
                                                     [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"diceViewController"]];
    UINavigationController *ticketableViewController = [[UINavigationController alloc] initWithRootViewController:
                                            [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"ticketableViewController"]];
   UINavigationController *taggableFriends = [[UINavigationController alloc] initWithRootViewController:
                                          [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"taggableFriends"]];
    UINavigationController *MYViewController =[[UINavigationController alloc] initWithRootViewController:
                                               [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"MYViewController"]];
    
    UINavigationController *feedbackViewController =[[UINavigationController alloc] initWithRootViewController:
                                                     [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"feedbackViewController"]];
    
  UINavigationController *SettingsScreenController =[[UINavigationController alloc] initWithRootViewController:
                                              [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"settingsScreen"]];
    
   
    
    /*UIViewController *settingsView=[[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"settingsScreen"];*/
    
    PHMenuViewController *menu = [[PHMenuViewController alloc] initWithRootViewController: self.navigationController
                                                                              atIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
    menu.viewControllers = @[self.navigationController, diceViewController,taggableFriends,ticketableViewController,MYViewController,SettingsScreenController,feedbackViewController,self.navigationController ];
    
    self.window.rootViewController = menu;
    
    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {

        [self showInstagramFeed];
    }
    else {
        dispatch_after(0, dispatch_get_main_queue(), ^{
            [self showHyperlapse];
        });
    }
    
    
    
    timer=[NSTimer scheduledTimerWithTimeInterval:90 target:self selector:@selector(registerNotification) userInfo:nil repeats:NO];
    
    return YES;
    
    
    
    
    
    
    
    
    
    
    
}



- (void)showHyperlapse {
    OnboardingContentViewController *firstPage = [[OnboardingContentViewController alloc] initWithTitle:@"Discover your Ultimate festival destination" body:@"" videoName:@"fevue1" buttonText:@"Enable Location Services" action:^{
        
    }];
    
    OnboardingContentViewController *secondPage = [[OnboardingContentViewController alloc] initWithTitle:@"Invite your friends to favourite festivals " body:@"" videoName:@"fevue2" buttonText:@"Connect With Facebook"  action:^{
       
    
    }];
    
    OnboardingContentViewController *thirdPage = [[OnboardingContentViewController alloc] initWithTitle:@"Get the latest festival news and purchase tickets " body:@"" videoName:@"fevue3" buttonText:@"Get Started - Tap Here" action:^{  [self showInstagramFeed];
    }];
    
    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundImage: [UIImage imageNamed: @"street"]
                                                                                              contents: @[firstPage, secondPage, thirdPage]];
    
    [self.navigationController pushViewController: onboardingVC animated: NO];
    
    
    
}

- (void)showInstagramFeed {
    //init controller
    SBInstagramController *instagram = [SBInstagramController instagram];
    
    //setting up, data were taken from instagram app setting (www.instagram.com/developer)
    instagram.instagramRedirectUri = @"http://www.fevue.com";
    instagram.instagramClientSecret = @"dd9f687e1ffb4ff48ebc77188a14d283";
    instagram.instagramClientId = @"436eb0b4692245c899091391eaa5cdf1";
    instagram.instagramMultipleDefaultAccessToken = @[@"6874212.436eb0b.9768fd326f9b423eab7dd260972ee6db",@"445694649.1677ed0.455eb0c367fc4d4f92ba266ddceedfad",@"199486979.5b9e1e6.08e4c1db0ca647ee83552bd5ba25bde1",@"610862091.1677ed0.7281f07b7dd14356a43c3f5f53b434c7",@"360967167.5b9e1e6.617f0eb085144c60b38990e0a649d4e3",@"1600165080.1677ed0.7fbe5f87e45142c3be79b6c55623ea58",@"1600167655.1677ed0.463c2cea58134cd19f84692675d42ab5",@"1600170516.1677ed0.fc832ba71cc1445b82ca88775da368fc"];
    
    //both are optional, but if you need search by tag you need set both
    //instagram.isSearchByTag = YES; //if you want serach by tag
    //instagram.searchTag = @"colombia"; //search by tag query
    
    //multiple users id or multiple tags (not both)
 
    instagram.instagramMultipleUsersId = @[@"186967582",@"290115357",@"058408835",@"367020264",@"1344258829",@"312807454",@"194112823",@"176096097",@"259430767",@"491745196",@"549298945",@"198048222",@"207741072",@"809211957",@"257034792",@"667028982",@"319273029",@"312860380",@"504085340",@"189890737",@"809211957",@"198595709",@"375752503",@"437781160",@"366581549",@"201872192",@"201872192",@"290768179",@"615941082",@"1432517303",@"485144081",@"215373547",@"42067004",@"270071750",@"178840137",@"349877534",@"335668434",@"471197969",@"176145002",@"18139564",@"292489864",@"712000876",@"1250519806",@"202482651",@"417416348",@"181396873" ];
   
        
    //instagram.instagramMultipleTags = @[@"london",@"paris",@"madrid"]; //if you set this you don't need set isSearchByTag in true
    
  //instagram.showOnePicturePerRow = YES; //to change way to show the feed, one picture per row(default = NO)
    
    //instagram.showSwitchModeView = YES; //show a segment controller with view option (default = NO)
    
    instagram.loadingImageName = @"loading.jpg"; //config a custom loading image
    instagram.videoPlayImageName = @"SBInsta_play"; //config a custom video play image
    instagram.videoPauseImageName = @"SBInsta_pause"; //config a custom video pause image
    instagram.playStandardResolution = YES; //if you want play a standard resuluton, low resolution per default
    

    
    //push instagram view controller into navigation
    [self.navigationController pushViewController: instagram.feed animated: YES];
}






- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[PFFacebookUtils session] close];
}









-(void)registerNotification
{
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //Right, that is the point
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert) categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else
    {
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert;
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current Installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}




- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSession.activeSession handleDidBecomeActive];
      [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    [FBAppEvents activateApp];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
        
        
    }



}



@end