//
//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "InvitedFriendsViewController.h"
#import "SKProgressIndicator.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GlobalClass.h"
#import "LoginViewController.h"
#import "PHMenuViewController.h"
#import "SBAppDelegate.h"
#import "SCLAlertView.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Social/SocialDefines.h>
#import "Flurry.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "VBFPopFlatButton.h"
#import "UIImageView+WebCache.h"
@interface InvitedFriendsViewController ()<AAShareBubblesDelegate,MFMailComposeViewControllerDelegate>

{
    int selectedFriendIndex;
}


@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;

@property (nonatomic, weak) IBOutlet Shade *accountNameLabel;
@property (nonatomic, weak) IBOutlet UIButton *accountImageButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *accountActivityIndicator;

@property (nonatomic, weak) IBOutlet Shade *friend1NameLabel;
@property (nonatomic, weak) IBOutlet UIButton *friend1ImageButton;

@property (nonatomic, weak) IBOutlet Shade *friend2NameLabel;
@property (nonatomic, weak) IBOutlet UIButton *friend2ImageButton;

@property (nonatomic, weak) IBOutlet Shade *friend3NameLabel;
@property (nonatomic, weak) IBOutlet UIButton *friend3ImageButton;
;
@property (nonatomic, weak) IBOutlet SKProgressIndicator *progressIndicator;


@end



@implementation InvitedFriendsViewController {

    float radius;
    float bubbleRadius;
}
@synthesize imageshare;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
  
    
    
    
    
    
    if ([UIScreen mainScreen].bounds.size.height<568)
    {
        
        
        _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(24, 439, 55, 55)
                                                         buttonType:buttonBackType
                                                        buttonStyle:buttonRoundedStyle
                                              animateToInitialState:YES];
        _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
        _flatRoundedButton.lineThickness = 1.5;
        _flatRoundedButton.lineRadius = 3;
        _flatRoundedButton.tintColor = [UIColor whiteColor];
        [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_flatRoundedButton];
        
        _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 439, 60, 60)
                                                         buttonType:buttonBackType
                                                        buttonStyle:buttonRoundedStyle
                                              animateToInitialState:YES];
        _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
        _flatRoundedButton.lineThickness = 1.5;
        _flatRoundedButton.lineRadius = 3;
        _flatRoundedButton.tintColor = [UIColor clearColor];
        [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_flatRoundedButton];
        
        
        

    }
    else
    {
        
        
        _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(22, 523, 25, 25)
                                                         buttonType:buttonBackType
                                                        buttonStyle:buttonRoundedStyle
                                              animateToInitialState:YES];
        _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
        _flatRoundedButton.lineThickness = 1.5;
        _flatRoundedButton.lineRadius = 3;
        _flatRoundedButton.tintColor = [UIColor whiteColor];
        [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_flatRoundedButton];
        
        
        _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 523, 60, 60)
                                                         buttonType:buttonBackType
                                                        buttonStyle:buttonRoundedStyle
                                              animateToInitialState:YES];
        _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
        _flatRoundedButton.lineThickness = 1.5;
        _flatRoundedButton.lineRadius = 3;
        _flatRoundedButton.tintColor = [UIColor clearColor];
        [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_flatRoundedButton];
        
        

    }

    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)configureForUser {
    if ([PFUser currentUser]) {
        if ([PFTwitterUtils isLinkedWithUser: [PFUser currentUser]]) {
            [self showAccountName: [PFTwitterUtils twitter].screenName andImage: nil];
            
            
            
            
        } else if ([PFFacebookUtils isLinkedWithUser: [PFUser currentUser]]) {
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
            
            
            
            {
                if (!error) {
                    NSString *displayName = result[@"name"];
                    
                    if (displayName) {
                        NSString *imageUrlString = [NSString stringWithFormat: @"http://graph.facebook.com/%@/picture?type=large", result[@"id"]];
                        NSURL *imageUrl = [NSURL URLWithString: imageUrlString];
                        NSURLSession *mainQueueSession = [NSURLSession sessionWithConfiguration: nil delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                        NSURLSessionDataTask *imageQueryTask = [mainQueueSession dataTaskWithURL: imageUrl
                                                                               completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                                   UIImage *responseImage = nil;
                                                                                   
                                                                                   if (error == nil) {
                                                                                       responseImage = [UIImage imageWithData: data];
                                                                                       
                                                                                       [self showAccountName: displayName andImage: responseImage];
                                                                                   }
                    
                                                                               
                                                                               
                                                                               
                                                                               }];
                        
                        
                        
                        
                        
                        [imageQueryTask resume];
                    }
                }
            }];
        } else {
            [self showAccountName: [PFUser currentUser].username andImage: nil];
        }
    

        
        
        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Sign Out"
                                                                             style: UIBarButtonItemStyleDone
                                                                            target: self
                                                                            action: @selector(signOut)];
        self.navigationItem.rightBarButtonItem = cancelButtonItem;
        
        // MARK
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Menu"
                                                                                 style: UIBarButtonItemStylePlain
                                                                                target: self
                                                                                action: @selector(showMenu)];
        typeof(self) bself = self;
        self.phSwipeHander = ^{
            [bself showMenu];
        };
    }
    else {
        
        [[[UIAlertView alloc] initWithTitle: @"Not Logged In"
                                    message: @"You need to be logged in to invite your friends. Log in now?"
                                   delegate: self
                          cancelButtonTitle: @"No"
                          otherButtonTitles: @"Yes", nil] show];
        [Flurry logEvent:@"Invite Friends - Not login First time"];
        NSLog(@"Invite Friends - Not login First time");
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
        [alert showError:self title:@"Hold On"
                subTitle:@"Connection with Facebook login  detected..."
        closeButtonTitle:@"OK" duration:0.0f];
    }
}


-(NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    

    if([GlobalClass sharedObject].isLocationSelected)
    {
        [logo setImage:[UIImage imageNamed:[GlobalClass sharedObject].imageName] forState:UIControlStateNormal];
        NSDate *currentDate=[NSDate date];
        int days=[self daysBetweenDate:currentDate andDate:[GlobalClass sharedObject].date];
        // self.progressIndicator.progressLabel.text=[GlobalClass sharedObject].daysLeft;
        self.progressIndicator.progressLabel.text=[NSString stringWithFormat:@"%d",days];
        
        [imgViewBG sd_setImageWithURL:[NSURL URLWithString:[GlobalClass sharedObject].imageName]];    }
   
    
    self.progressIndicator.percentInnerCircle = 60;
    
    [self.progressIndicator setNeedsDisplay];
    
    [self configureForUser];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        PHMenuViewController *menuController = (PHMenuViewController*)((SBAppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
        
        [menuController switchToViewController: menuController.viewControllers[0] atIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0]];
               NSLog(@"Invite Friends - user cancel the login");
         [Flurry logEvent:@"Invite Friends - user cancel the login"];
    }
    else {
         [Flurry logEvent:@"Invite Friends - user taking to login"];
        NSLog(@"Invite Friends - user taking to login");
        LoginViewController *logInViewController = [[LoginViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = @[@"friends_about_me, user_friends,email"];
        logInViewController.fields = PFLogInFieldsFacebook;
  
        
        
        
        
        [self presentViewController: logInViewController animated: YES completion: nil];
    }
}


- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated: YES completion: nil];
    
    [self configureForUser];
}


- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}


- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
      [Flurry logEvent:@"User dismissed the InviteViewController"];
}



- (void)showAccountName: (NSString*)accountName andImage: (UIImage*)accountImage {
    self.accountNameLabel.text = accountName;
    
    [self.accountImageButton setImage: accountImage forState: UIControlStateNormal];
    self.accountImageButton.imageView.layer.cornerRadius = self.accountImageButton.imageView.frame.size.width / 2;
    self.accountImageButton.imageView.layer.borderWidth = 1;
    self.accountImageButton.imageView.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.accountActivityIndicator stopAnimating];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(![segue.identifier isEqualToString:@"selectLocation"])
    {
        TaggableFriendsViewController *taggableFriendsController = (TaggableFriendsViewController*)segue.destinationViewController;
        taggableFriendsController.delegate = self;
        
        if ([segue.identifier isEqualToString: @"Friend1SelectionSegue"]) {
            selectedFriendIndex = 1;
        } else if ([segue.identifier isEqualToString: @"Friend2SelectionSegue"]) {
            selectedFriendIndex = 2;
        } else if ([segue.identifier isEqualToString: @"Friend3SelectionSegue"]) {
            selectedFriendIndex = 3;
        }
    }
}


- (void)friendSelected: (NSDictionary*)selectedFriendDetails {
    UIButton *friendImageButton = nil;
    UILabel *friendNameLabel = nil;
    
    switch (selectedFriendIndex) {
        case 1: {
            friendImageButton = self.friend1ImageButton;
            friendNameLabel = self.friend1NameLabel;
            
            break;
        }
        case 2: {
            friendImageButton = self.friend2ImageButton;
            friendNameLabel = self.friend2NameLabel;
            
            break;
        }
        case 3: {
            friendImageButton = self.friend3ImageButton;
            friendNameLabel = self.friend3NameLabel;
            
            break;
        }
        default:
            break;
    }
    
    NSString *selectedFriendImageUrlString = [selectedFriendDetails valueForKeyPath: @"picture.data.url"];
    NSURL *selectedFriendImageUrl = [NSURL URLWithString: selectedFriendImageUrlString];
    UIImage *selectedFriendImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: selectedFriendImageUrl]];
    [friendImageButton setImage: selectedFriendImage forState: UIControlStateNormal];
    friendImageButton.imageView.layer.cornerRadius = friendImageButton.imageView.frame.size.width / 2;
    friendImageButton.imageView.layer.borderWidth = 2;
    friendImageButton.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    friendNameLabel.text = selectedFriendDetails[@"name"];
}


- (void)showMenu {
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
}


- (void)signOut {
    [PFUser logOut];
    self.accountNameLabel =nil;
    self.accountImageButton = nil;
    
 
    
    
    
    NSIndexPath *feedControllerIndexPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
    UIViewController *feedController = [self.airViewController getViewControllerAtIndexPath: feedControllerIndexPath];
    [self.airViewController switchToViewController: feedController atIndexPath: feedControllerIndexPath];
}


-(IBAction)buttonPress:(id)sender
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageshare = UIImageJPEGRepresentation(image,1.0);
    
 
    
 }



- (IBAction)share:(id)sender

{
    {AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(160, 250)
                                                                   radius:100
                                                                   inView:self.view];
        shareBubbles.delegate = self;
        shareBubbles.bubbleRadius = 35; // Default is 40
        shareBubbles.showFacebookBubble = YES;
        shareBubbles.showTwitterBubble = YES;
        shareBubbles.showMailBubble = YES;
        shareBubbles.showInstagramBubble = YES;
        shareBubbles.showPinterestBubble = YES;
        [shareBubbles show];
    }
}


-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType)
        {
        case AAShareBubbleTypeFacebook:

            {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Fevue: Invite friend to your favourite festival"];
                [controller addURL:[NSURL URLWithString:@"http://deeplink.me/fevue.com"]];
                [controller addImage:[UIImage imageWithData:imageshare]];
                
                [self presentViewController:controller animated:YES completion:Nil];
                
                
            }
                
                     [Flurry logEvent:@"Invite Friends -Facebook Share "];
                break;
                    case AAShareBubbleTypeTwitter:
            {    SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:@"Fevue: Invite friend to your favourite festival"];
                [tweetSheet addURL:[NSURL URLWithString:@"http://deeplink.me/fevue.com/"]];
                [tweetSheet addImage:[UIImage imageWithData:imageshare]];
                
                [self presentViewController:tweetSheet animated:YES completion:nil];

            }
                
                 [Flurry logEvent:@"Invite Friends -Twitter Share "];
                break;
       
            case AAShareBubbleTypeInstagram:
            {
    
                
                NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=FEVUE"];
                if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
                    [[UIApplication sharedApplication] openURL:instagramURL];
                

                            
                }
            [Flurry logEvent:@"Invite Friends -Instagram Share "];
                
                break;
           
            
            case AAShareBubbleTypeMail:
            {

             
                
                if ( [MFMailComposeViewController canSendMail] ) {
                    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
                    mailComposer.mailComposeDelegate = self;
                    [mailComposer addAttachmentData:imageshare mimeType:@"image/jpeg" fileName:@"attachment.jpg"];
                    
                    /* Configure other settings */
                    
                  [self presentViewController:mailComposer animated:YES completion:nil];
                
                }
            }
        [Flurry logEvent:@"Invite Friends -Email Share "];
                
                break;
        case AAShareBubbleTypePinterest:
            {
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                
                UIColor *color = [UIColor whiteColor];
                [alert showCustom:self image:[UIImage imageNamed:@"git"] color:color title:@"Pinterest" subTitle:@"Pinterest app has not being found" closeButtonTitle:nil duration:2.0f];
            }
                 [Flurry logEvent:@"Invite Friends -Pinterest Share "];
                NSLog(@"Vkontakte (vk.com)");
            break;
            default:
            break;
    }
}


-(void)aaShareBubblesDidHide:(AAShareBubbles*)bubbles {
    NSLog(@"All Bubbles hidden");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setShareButton:nil];
    [super viewDidUnload];
}



- (void)buttonPressed:(id)sender {
   
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end