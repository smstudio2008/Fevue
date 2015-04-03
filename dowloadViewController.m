//
//  dowloadViewController.m
//  fevue
//
//  Created by SALEM on 27/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#define IMAGE_VIEW_TAG 100
#define IMAGE_SCROLL_VIEW_TAG 101
#define CONTENT_IMAGE_VIEW_TAG 102

#import "dowloadViewController.h"
#import "MHYahooParallaxView.h"
#import "MHTsekotCell.h"
#import "HTPressableButton.h"
#import "UIColor+HTColor.h"
#import "instaController.h"
#import <MapKit/MapKit.h>
#import "JBWebViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "FSViewController.h"
#import "FSRotatingCamera.h"
#import "ATLabel.h"
#import "UIViewController+ENPopUp.h"
#import "Flurry.h"
#import "VBFPopFlatButton.h"

@interface dowloadViewController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) HTPressableButton* rectButton;
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property (nonatomic, strong) MKMapView *mapView;
@property (strong, nonatomic) ATLabel *animatedLabel;
@property (strong, nonatomic) ATLabel *animatedLabel2;


@end

@implementation dowloadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _imageHeaderHeight = self.view.frame.size.height * 0.75f;
    
    MHYahooParallaxView * parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [parallaxView registerClass:[MHTsekotCell class] forCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier]];
    parallaxView.delegate = self;
    parallaxView.datasource = self;
    [self.view addSubview:parallaxView];

    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(20, 24, 22, 22)
                                                     buttonType:buttonDownArrowType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: _flatRoundedButton];
    
    
    
    
    
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    
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
    return 810.0f;
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
            imageView.contentMode = UIViewContentModeCenter;
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
            UIImageView * headerInfo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header_bgd"]];
            
            [cell.contentView addSubview:headerInfo];
            
            CGRect headerFrame = headerInfo.frame;
            headerFrame.size.height = 149.0f;
            headerFrame.origin.y = _imageHeaderHeight - 149.0f;
            headerInfo.frame = headerFrame;
            
        }
        
        
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:IMAGE_VIEW_TAG];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"download.jpg"]];
    } else {
        static NSString * detailId = @"detailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:detailId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailId];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320, 570.0f)];
            imageView.tag = CONTENT_IMAGE_VIEW_TAG;
            
            [cell.contentView addSubview:imageView];
            
            
            
            CGRect frame = CGRectMake(0, 130, 160, 120);
            HTPressableButton *rectButton = [[HTPressableButton alloc] initWithFrame:frame buttonStyle:HTPressableButtonStyleRect];
            rectButton.buttonColor = [UIColor ht_bitterSweetColor];
            rectButton.shadowColor =  [UIColor clearColor];
            [rectButton setTitle:@"LINE-UP" forState:UIControlStateNormal];
            rectButton.font =[UIFont fontWithName:@"AvenirNext-UltraLight" size:35];
            [cell.contentView  addSubview:rectButton];
            [rectButton addTarget:self action:@selector(lineup) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
            
            
            CGRect frame2 = CGRectMake(160, 130, 160, 120);
            HTPressableButton *rectButton2 = [[HTPressableButton alloc] initWithFrame:frame2 buttonStyle:HTPressableButtonStyleRect];
            rectButton2.buttonColor = [UIColor ht_grapeFruitColor];
            rectButton2.shadowColor = [UIColor clearColor];
            rectButton2.font =[UIFont fontWithName:@"AvenirNext-Regular" size:35];
            [rectButton2 setTitle:@"TICKETS" forState:UIControlStateNormal];
            [cell.contentView  addSubview:rectButton2];
            [rectButton2 addTarget:self action:@selector(ticket) forControlEvents:UIControlEventTouchUpInside];
            
            
            CGRect frame5 = CGRectMake(40,625, 110, 110);
            HTPressableButton *circularButton1 = [[HTPressableButton alloc] initWithFrame:frame5 buttonStyle:HTPressableButtonStyleCircular];
            circularButton1.buttonColor = [UIColor ht_belizeHoleColor];
            circularButton1.shadowColor = [UIColor clearColor];
            [circularButton1 setTitle:@"" forState:UIControlStateNormal];
            
            [circularButton1 addTarget:self action:@selector(facebook) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:circularButton1];
            
            UIImageView *dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(45,625,100,100)];
            dot2.image=[UIImage imageNamed:@"face.png"];
            [cell.contentView addSubview:dot2];
            
            
            
            CGRect frame4 = CGRectMake(170, 625, 110, 110);
            HTPressableButton *circularButton = [[HTPressableButton alloc] initWithFrame:frame4 buttonStyle:HTPressableButtonStyleCircular];
            circularButton.buttonColor = [UIColor ht_jayColor];
            circularButton.shadowColor = [UIColor clearColor];
            [circularButton setTitle:@"" forState:UIControlStateNormal];
            
            [circularButton addTarget:self action:@selector(twitter) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:circularButton];
            
            UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(175,625,100,100)];
            dot.image=[UIImage imageNamed:@"twit.png"];
            [cell.contentView addSubview:dot];
            
            
            CGRect frame6 = CGRectMake(0, 370, 320, 50);
            HTPressableButton *rectButton5 = [[HTPressableButton alloc] initWithFrame:frame6 buttonStyle:HTPressableButtonStyleRect];
            rectButton5.buttonColor = [UIColor  clearColor];
            rectButton5.shadowColor = [UIColor clearColor];
            rectButton5.font =[UIFont fontWithName:@"AvenirNext-meduim" size:30];
            
            [rectButton5 setTitle:@"TAKE ME THERE" forState:UIControlStateNormal];
            [cell.contentView  addSubview:rectButton5];
            
            CGRect frame7 = CGRectMake(0, 238, 320, 120);
            HTPressableButton *rectButton6 = [[HTPressableButton alloc] initWithFrame:frame7 buttonStyle:HTPressableButtonStyleRect];
            rectButton6.buttonColor = [UIColor clearColor];
            rectButton6.shadowColor = [UIColor clearColor];
            [rectButton6 addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView  addSubview:rectButton6];
            UIImageView *map =[[UIImageView alloc] initWithFrame:CGRectMake(0, 238, 320, 180)];
            map.image=[UIImage imageNamed:@"mapdown.jpg"];
            [cell.contentView addSubview:map];
            
            
            CGRect frame8 = CGRectMake(0, 415, 320, 160);
            HTPressableButton *rectButton7 = [[HTPressableButton alloc] initWithFrame:frame8 buttonStyle:HTPressableButtonStyleRect];
            rectButton7.buttonColor = [UIColor clearColor];
            rectButton7.shadowColor = [UIColor clearColor];
            [rectButton7 addTarget:self action:@selector(aftermovie) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView  addSubview:rectButton7];
            
            UIImageView *after =[[UIImageView alloc] initWithFrame:CGRectMake(0, 415, 320, 200)];
            after.image=[UIImage imageNamed:@"down-after.jpg"];
            [cell.contentView addSubview:after];
            
            _animatedLabel = [[ATLabel alloc] initWithFrame:CGRectMake(10, 347, 320, 100)];
            [_animatedLabel animateWithWords:@[
                                               @"Festival Map",
                                               @"Castle Donington, Leicestershire"
                                               
                                               ]
                                 forDuration:8.0f
                               withAnimation:ATAnimationTypeFadeInOut];
            
            
            _animatedLabel.font =[UIFont fontWithName:@"Avenir-medium" size:12];
            [cell.contentView addSubview:_animatedLabel];
            
            
            _animatedLabel2 = [[ATLabel alloc] initWithFrame:CGRectMake(10, 520, 320, 100)];
            [_animatedLabel2 animateWithWords:@[
                                                @"Aftermovie",
                                                @"Download Festival 2014 Highlights"
                                                
                                                ]
                                  forDuration:5.0f
                                withAnimation:ATAnimationTypeFadeInOut];
            
            
            _animatedLabel2.font =[UIFont fontWithName:@"Avenir-Black" size:15];
            _animatedLabel2.textColor=[UIColor whiteColor];
            [cell.contentView addSubview:_animatedLabel2];
            
            
            CGRect frame9 = CGRectMake(0, 735, 320, 90);
            HTPressableButton *rectButton9 = [[HTPressableButton alloc] initWithFrame:frame9 buttonStyle:HTPressableButtonStyleRect];
            rectButton9.buttonColor = [UIColor ht_peterRiverColor];
            rectButton9.shadowColor =  [UIColor clearColor];
            [rectButton9 setTitle:@"EXPLORE" forState:UIControlStateNormal];
                rectButton9.font =[UIFont fontWithName:@"AvenirNext-UltraLight" size:70];
            [rectButton9 addTarget:self action:@selector(showInstagramFeed) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:rectButton9];
            
            
            
            
            
            
            
            
        }
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:CONTENT_IMAGE_VIEW_TAG];
        imageView.image = [UIImage imageNamed:@"down.content.png"];
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


- (void)showInstagramFeed {
    //init controller
    instaController *instagram = [instaController instagram];
    
    //setting up, data were taken from instagram app setting (www.instagram.com/developer)
    instagram.instagramRedirectUri = @"http://www.santiagobustamante.info";
    instagram.instagramClientSecret = @"dd9f687e1ffb4ff48ebc77188a14d283";
    instagram.instagramClientId = @"436eb0b4692245c899091391eaa5cdf1";
    instagram.instagramDefaultAccessToken = @"6874212.436eb0b.9768fd326f9b423eab7dd260972ee6db";
    instagram.instagramUserId = @"176145002"; //if you want request the feed of one user
    
    //both are optional, but if you need search by tag you need set both
    //instagram.isSearchByTag = YES; //if you want serach by tag
    //instagram.searchTag = @"colombia"; //search by tag query
    
    
    instagram.instagramMultipleTags = @[@"downloadfestival",@"download2014",@"downloadfest"]; //if you set this you don't need set isSearchByTag in true
    //instagram.showOnePicturePerRow = YES; //to change way to show the feed, one picture per row(default = NO)
    
    
    //instagram.showSwitchModeView = YES; //show a segment controller with view option (default = NO)
    
    instagram.loadingImageName = @"SBInstagramLoading"; //config a custom loading image
    instagram.videoPlayImageName = @"SBInsta_play"; //config a custom video play image
    instagram.videoPauseImageName = @"SBInsta_pause"; //config a custom video pause image
    instagram.playStandardResolution = YES; //if you want play a standard resuluton, low resolution per default
    
    [instagram refreshCollection2]; //refresh instagram feed
    
    //push instagram view controller into navigation
    [self presentModalViewController: instagram.feed animated:YES];}





- (void)buttonPressed:(id)sender {

    [self dismissPopUpViewController];

    [Flurry logEvent:@"Back to main menu button- download"];
}



-(void)lineup {
    
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://downloadfestival.co.uk/line-up"]];
    [controller show];
        [Flurry logEvent:@"lineup- download"];
    
}


-(void)ticket {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://downloadfestival.co.uk/tickets"]];
    [controller show];
      [Flurry logEvent:@"ticket- download"];
}



-(void)aftermovie {
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"xITWAu76pPo"];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
         [Flurry logEvent:@"aftermovie- download"];
}


-(void)facebook {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://www.facebook.com/downloadfest"]];
    [controller show];
             [Flurry logEvent:@"facebook- download"];}



-(void)twitter {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://twitter.com/downloadfest"]];
    [controller show];
    
[Flurry logEvent:@"twitter- download"];}



- (void)map {
    
}





@end
