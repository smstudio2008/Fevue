//
//  feedbackViewController.m
//  fevue
//
//  Created by SALEM on 08/12/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#define IMAGE_VIEW_TAG 100
#define IMAGE_SCROLL_VIEW_TAG 101
#define CONTENT_IMAGE_VIEW_TAG 102

#import "feedbackViewController.h"
#import "MHYahooParallaxView.h"
#import "MHTsekotCell.h"
#import "HTPressableButton.h"
#import "UIColor+HTColor.h"
#import <MessageUI/MessageUI.h>
#import "VBFPopFlatButton.h"
#import <Social/Social.h>
#import <Social/SocialDefines.h>
#import "SCLAlertView.h"
#import "Flurry.h"


@interface feedbackViewController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@end

@implementation feedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    _imageHeaderHeight = self.view.frame.size.height * 0.60f;
    
    MHYahooParallaxView * parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f,-10.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [parallaxView registerClass:[MHTsekotCell class] forCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier]];
    parallaxView.delegate = self;
    parallaxView.datasource = self;
    [self.view addSubview:parallaxView];
    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_flatRoundedButton];
    

    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 24, 50, 50)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_flatRoundedButton];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"feedbackView"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             PFFile *file=[[objects objectAtIndex:0] valueForKey:@"background"];
             
             [_imgView setImageWithURL:[NSURL URLWithString:file.url]  usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

         }
     }];
    
    
    
    
    
    
    
    
    
 }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ParallaxView Datasource and Delegate
- (UICollectionViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHTsekotCell * tsekotCell = (MHTsekotCell*)[parallaxView dequeueReusableCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier] forIndexPath:indexPath];
    tsekotCell.delegate = self;
    tsekotCell.datasource = self;
    tsekotCell.tsekotTableView.tag = indexPath.row;
    tsekotCell.tsekotTableView.contentOffset = CGPointMake(0.0f, 0.0f);
    [tsekotCell.tsekotTableView reloadData];
    
    return tsekotCell;
}


- (NSInteger) numberOfRowsInParallaxView:(MHYahooParallaxView *)parallaxView {
    return 1;
}



#pragma mark - TableView Datasource and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return _imageHeaderHeight;
    }
    return 330.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if(indexPath.row == 0){
        static NSString * headerId = @"headerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:headerId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:headerId];
            cell.backgroundColor = [UIColor clearColor];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, cell.contentView.frame.size.width,_imageHeaderHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.tag = IMAGE_VIEW_TAG;
            imageView.clipsToBounds = YES;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            UIScrollView * svImage = [[UIScrollView alloc]initWithFrame:imageView.frame];
            svImage.delegate = self;
            svImage.userInteractionEnabled = NO;
            
            [svImage addSubview:imageView];
            
            svImage.tag = IMAGE_SCROLL_VIEW_TAG;
            svImage.zoomScale = 0.0f;
            svImage.minimumZoomScale = 1.0f;
            svImage.maximumZoomScale = 2.0f;
            [cell.contentView addSubview:svImage];
            UIImageView * headerInfo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header_bge"]];
            
            [cell.contentView addSubview:headerInfo];
            
            CGRect headerFrame = headerInfo.frame;
            headerFrame.size.height = 149.0f;
            headerFrame.origin.y = _imageHeaderHeight - 149.0f;
            headerInfo.frame = headerFrame;
            
        }
        
        
        _imgView = (UIImageView*)[cell viewWithTag:IMAGE_VIEW_TAG];
    } else {
        static NSString * detailId = @"detailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:detailId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailId];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320, 570.0f)];
            imageView.tag = CONTENT_IMAGE_VIEW_TAG;
            
            [cell.contentView addSubview:imageView];

            
            
            CGRect frame = CGRectMake(0, 0, 320, 70);
            HTPressableButton *rectButton = [[HTPressableButton alloc] initWithFrame:frame buttonStyle:HTPressableButtonStyleRect];
            rectButton.buttonColor = [UIColor ht_mediumDarkColor];
            rectButton.shadowColor = [UIColor ht_mediumDarkColor];
            [rectButton setTitle:@"SEND US FEEDBACK" forState:UIControlStateNormal];
            rectButton.titleLabel.font =[UIFont fontWithName:@"Avenir-light" size:25];
                 [cell.contentView  addSubview:rectButton];
            [rectButton addTarget:self action:@selector(emailSupport) forControlEvents:UIControlEventTouchUpInside];
            
            
            CGRect frame2 = CGRectMake(0, 65, 320, 70);
            HTPressableButton *rectButton2 = [[HTPressableButton alloc] initWithFrame:frame2 buttonStyle:HTPressableButtonStyleRect];
            rectButton2.buttonColor = [UIColor ht_blueJeansDarkColor];
            rectButton2.shadowColor = [UIColor ht_blueJeansDarkColor];
            [rectButton2 setTitle:@"RATE OUR APP" forState:UIControlStateNormal];
            rectButton2.titleLabel.font =[UIFont fontWithName:@"Avenir-light" size:25];
             [rectButton2 addTarget:self action:@selector(rate) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView  addSubview:rectButton2];
            
            
     
            CGRect frame3 = CGRectMake(0, 125, 320, 25);
            HTPressableButton *rectButton3 = [[HTPressableButton alloc] initWithFrame:frame3 buttonStyle:HTPressableButtonStyleRect];
            rectButton3.buttonColor = [UIColor ht_midnightBlueColor];
            rectButton3.shadowColor = [UIColor ht_midnightBlueColor];
            rectButton3.titleLabel.font =[UIFont fontWithName:@"Avenir-Book" size:15];
            [rectButton3 setTitle:@"Share with friends" forState:UIControlStateNormal];
               [cell.contentView  addSubview:rectButton3];
            
            
            
            CGRect frame4 = CGRectMake(0, 150, 107, 90);
            HTPressableButton *rectButton4 = [[HTPressableButton alloc] initWithFrame:frame4 buttonStyle:HTPressableButtonStyleRect];
            rectButton4.buttonColor = [UIColor ht_jayColor];
            rectButton4.shadowColor = [UIColor ht_jayColor];
            [rectButton4 setTitle:@"" forState:UIControlStateNormal];
            
             [rectButton4 addTarget:self action:@selector(twitter) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView   addSubview:rectButton4];
            
            UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(5,140,100,100)];
            dot.image=[UIImage imageNamed:@"twit.png"];
            [cell.contentView addSubview:dot];
            
         
            CGRect frame5 = CGRectMake(107, 150, 107, 90);
            HTPressableButton *rectButton5 = [[HTPressableButton alloc] initWithFrame:frame5 buttonStyle:HTPressableButtonStyleRect];
            rectButton5.buttonColor = [UIColor ht_belizeHoleColor];
            rectButton5.shadowColor = [UIColor ht_belizeHoleColor];
            [rectButton5 setTitle:@"" forState:UIControlStateNormal];
           [rectButton5 addTarget:self action:@selector(facebook) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:rectButton5];
            
            UIImageView *dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(110,143,100,100)];
            dot2.image=[UIImage imageNamed:@"face.png"];
            [cell.contentView addSubview:dot2];
            
            
            CGRect frame8 = CGRectMake(214, 150, 107, 90);
            HTPressableButton *rectButton8 = [[HTPressableButton alloc] initWithFrame:frame8 buttonStyle:HTPressableButtonStyleRect];
            rectButton8.buttonColor = [UIColor ht_wisteriaColor];
            rectButton8.shadowColor = [UIColor ht_wisteriaColor];
            [rectButton8 setTitle:@"" forState:UIControlStateNormal];
               [rectButton8 addTarget:self action:@selector(email) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:rectButton8];
            
            
            UIImageView *dot3 =[[UIImageView alloc] initWithFrame:CGRectMake(218, 145, 100, 100)];
            dot3.image=[UIImage imageNamed:@"mail.png"];
            [cell.contentView addSubview:dot3];
            
            
            
            CGRect frame6 = CGRectMake(0, 240, 107, 90);
            HTPressableButton *rectButton6 = [[HTPressableButton alloc] initWithFrame:frame6 buttonStyle:HTPressableButtonStyleRect];
            rectButton6.buttonColor = [UIColor ht_pomegranateColor];
            rectButton6.shadowColor = [UIColor ht_pomegranateColor];
            [rectButton6 setTitle:@"" forState:UIControlStateNormal];
                  [rectButton6 addTarget:self action:@selector(pin) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:rectButton6];
            

            UIImageView *dot4 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 235, 100, 100)];
            dot4.image=[UIImage imageNamed:@"pin.png"];
            [cell.contentView addSubview:dot4];
            
            

            CGRect frame9 = CGRectMake(107, 240, 107, 90);
            HTPressableButton *rectButton9 = [[HTPressableButton alloc] initWithFrame:frame9 buttonStyle:HTPressableButtonStyleRect];
            rectButton9.buttonColor = [UIColor ht_lemonDarkColor];
            rectButton9.shadowColor = [UIColor ht_lemonDarkColor];
            [rectButton9 setTitle:@"" forState:UIControlStateNormal];
            [cell.contentView addSubview:rectButton9];
                        
            UIImageView *dot5 =[[UIImageView alloc] initWithFrame:CGRectMake(108, 240, 107, 90)];
            dot5.image=[UIImage imageNamed:@"google.png"];
            [cell.contentView addSubview:dot5];
            
            CGRect frame7 = CGRectMake(214, 240, 107, 90);
            HTPressableButton *rectButton7 = [[HTPressableButton alloc] initWithFrame:frame7 buttonStyle:HTPressableButtonStyleRect];
            rectButton7.buttonColor = [UIColor ht_nephritisColor];
            rectButton7.shadowColor = [UIColor ht_nephritisColor];
            [rectButton7 setTitle:@"" forState:UIControlStateNormal];
            [rectButton7 addTarget:self action:@selector(whatapp) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:rectButton7];
            
            
            UIImageView *dot6 =[[UIImageView alloc] initWithFrame:CGRectMake(217, 240, 100, 90)];
            dot6.image=[UIImage imageNamed:@"whatapp.png"];
            [cell.contentView addSubview:dot6];
            
            
            
            
        }
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:CONTENT_IMAGE_VIEW_TAG];
        imageView.image = [UIImage imageNamed:@"feedbackback.png"];
    }
    
    
    return cell;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.tag == IMAGE_SCROLL_VIEW_TAG) return;
    UITableView * tv = (UITableView*) scrollView;
    UITableViewCell * cell = [tv cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UIScrollView * svImage = (UIScrollView*)[cell viewWithTag:IMAGE_SCROLL_VIEW_TAG];
    CGRect frame = svImage.frame;
    frame.size.height =  MAX((_imageHeaderHeight-tv.contentOffset.y),0);
    frame.origin.y = tv.contentOffset.y;
    svImage.frame = frame;
    svImage.zoomScale = 1 + (abs(MIN(tv.contentOffset.y,0))/220.0f);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:IMAGE_VIEW_TAG];
}


- (void)emailSupport
{
    NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
    NSString *model = [[UIDevice currentDevice] model];
    NSString *version = @"1.0";
    NSString *build = @"100";
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:[NSArray arrayWithObjects: @"support@fevue.com",nil]];
    [mailComposer setSubject:[NSString stringWithFormat: @"My Feedback about Fevue",version,build]];
    NSString *supportText = [NSString stringWithFormat:@"Device: %@\niOS Version:%@\n\n",model,iOSVersion];
    supportText = [supportText stringByAppendingString: @"Please describe your problem or question."];
    [mailComposer setMessageBody:supportText isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
       [Flurry logEvent:@"feedback Fevue-emailsupport"];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rate{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/fevue/id907509772?mt=8"]];
    
       [Flurry logEvent:@"feedback Fevue-rate us"];
}

- (void)buttonPressed:(id)sender {
    
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
}

-(void)facebook{
SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

[controller setInitialText:@"Fevue: Discover your ultimate festival destination from around the world"];
[controller addURL:[NSURL URLWithString:@"http://deeplink.me/fevue.com"]];
[controller addImage:[UIImage imageNamed:@"facebooksharing.png"]];

[self presentViewController:controller animated:YES completion:Nil];
   [Flurry logEvent:@"feedback Fevue-facebook"];
}

-(void)twitter{

SLComposeViewController *tweetSheet = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
[tweetSheet setInitialText:@"Fevue: Discover your ultimate festival destination from around the world"];
[tweetSheet addURL:[NSURL URLWithString:@"http://deeplink.me/fevue.com/"]];
[tweetSheet addImage:[UIImage imageNamed:@"facebooksharing.png"]];

[self presentViewController:tweetSheet animated:YES completion:nil];
   [Flurry logEvent:@"feedback Fevue-twitter"];

}
-(void)pin{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];

UIColor *color = [UIColor whiteColor];
[alert showCustom:self image:[UIImage imageNamed:@"git"] color:color title:@"Pinterest" subTitle:@"Pinterest app has not being found" closeButtonTitle:nil duration:2.0f];
   [Flurry logEvent:@"feedback Fevue-Pinterest"];
}


-(void)email{
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:[NSString stringWithFormat: @"Fevue-Check this App"]];
    NSString *supportText = [NSString stringWithFormat:@""];
    supportText = [supportText stringByAppendingString: @"Hi,I just found this great festival app for the iPhone called Fevue."
             @"It will help us discover new and exciting festival destinations . You should definitely try it out.."      ];

    
    [mailComposer setMessageBody:supportText isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
    
    
    [Flurry logEvent:@"feedback Fevue-Email"];
}


-(void)whatapp{
    NSString * msg = @"http://deeplink.me/fevue.com/";
    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    } else {        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        UIColor *color = [UIColor whiteColor];
        [alert showCustom:self image:[UIImage imageNamed:@"git"] color:color title:@"WhatsApp" subTitle:@"WhatsApp has not being found" closeButtonTitle:nil duration:2.0f];
    }

}

@end
