//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#define IMAGE_VIEW_TAG 600
#define IMAGE_SCROLL_VIEW_TAG 101
#define CONTENT_IMAGE_VIEW_TAG 102


#import "bestivalController.h"
#import "MHYahooParallaxView.h"
#import "MHTsekotCell.h"
#import "HTPressableButton.h"
#import "UIColor+HTColor.h"
#import "instaController.h"
#import <MapKit/MapKit.h>
#import "JBWebViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "ATLabel.h"
#import "Flurry.h"
#import "VBFPopFlatButton.h"
#import "GoogleMapViewConttlloerViewController.h"


@interface bestivalController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) HTPressableButton* rectButton;
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property (nonatomic, strong) MKMapView *mapView;
@property (strong, nonatomic) ATLabel *animatedLabel;
@property (strong, nonatomic) ATLabel *animatedLabel2;


@end




@implementation bestivalController




- (void)viewDidLoad
{
    
      
   [super viewDidLoad];

[self.navigationController setNavigationBarHidden:YES];
    
    _imageHeaderHeight = self.view.frame.size.height * 0.62f;
    
    MHYahooParallaxView * parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [parallaxView registerClass:[MHTsekotCell class] forCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier]];
    parallaxView.delegate = self;
    parallaxView.datasource = self;
    [self.view addSubview:parallaxView];
    
    
    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(20, 30, 22, 22)
                                                     buttonType:buttonBackType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: _flatRoundedButton];
    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 10, 50, 45)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonPlainStyle
                                          animateToInitialState:NO];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 20;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_flatRoundedButton];
    
    
    
    
    
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"festivalDetailView"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             PFFile *file=[[objects objectAtIndex:0] valueForKey:@"background"];
             
               PFFile *file1=[[objects objectAtIndex:0] valueForKey:@"afterMovie"];
             
             
             
           [_imgView setImageWithURL:[NSURL URLWithString:file.url]  usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
              
               [_imgView1 setImageWithURL:[NSURL URLWithString:file1.url]  usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
             
             
             
         } 
     }];
    
    
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    
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
    return 880.0f;
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
            
        }
        
        
        _imgView = (UIImageView*)[cell viewWithTag:IMAGE_VIEW_TAG];
           } else {
        static NSString * detailId = @"detailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:detailId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailId];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320, 570.0f)];
            imageView.tag = CONTENT_IMAGE_VIEW_TAG;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:imageView];
            
      
       
          UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
            [Button setTitle:@"LINE-UP" forState:UIControlStateNormal];
            Button.titleLabel.font =[UIFont fontWithName:@"AvenirNext-UltraLight" size:40];
            [cell.contentView  addSubview:Button];
            [Button addTarget:self action:@selector(lineup) forControlEvents:UIControlEventTouchUpInside];
            Button.frame = CGRectMake(0, 200, 160, 105);
            Button.backgroundColor = [UIColor colorWithRed:0.949 green:0.475 blue:0.208 alpha:1];
            
            
            UIButton *Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [Button1 setTitle:@"INFO" forState:UIControlStateNormal];
            Button1.titleLabel.font =[UIFont fontWithName:@"Avenir-Black" size:40];
            [cell.contentView  addSubview:Button1];
            [Button1 addTarget:self action:@selector(ticket) forControlEvents:UIControlEventTouchUpInside];
            Button1.frame = CGRectMake(160, 200, 160, 105);
            Button1.backgroundColor =[UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1];
            
            
            
            
            UIButton *Button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
               [cell.contentView  addSubview:Button5];
            [Button5 addTarget:self action:@selector(facebook) forControlEvents:UIControlEventTouchUpInside];
            Button5.frame = CGRectMake(45,695, 100, 100);
            Button5.backgroundColor = [UIColor colorWithRed:0.267 green:0.424 blue:0.702 alpha:1];
             Button5.layer.cornerRadius =50;
            
            UIImageView *dot2 =[[UIImageView alloc] initWithFrame:CGRectMake(45,695,100,100)];
            dot2.image=[UIImage imageNamed:@"face.png"];
            [cell.contentView addSubview:dot2];
            
            
         
            
            UIButton *Button6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cell.contentView  addSubview:Button6];
            [Button6 addTarget:self action:@selector(twitter) forControlEvents:UIControlEventTouchUpInside];
            Button6.frame = CGRectMake(175, 695, 100, 100);
            Button6.backgroundColor = [UIColor colorWithRed:0.42 green:0.725 blue:0.941 alpha:1];
             Button6.layer.cornerRadius =50;
            
            UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(175,695,100,100)];
            dot.image=[UIImage imageNamed:@"twit.png"];
            [cell.contentView addSubview:dot];
            

            

           
            UIButton *Button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell.contentView  addSubview:Button2];
            [Button2 addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
            Button2.frame = CGRectMake(0, 308, 320, 180);
            Button2.backgroundColor = [UIColor clearColor];
             UIImageView *map =[[UIImageView alloc] initWithFrame:CGRectMake(0, 308, 320, 180)];
              map.image=[UIImage imageNamed:@"mapbestival.jpg"];
            [cell.contentView addSubview:map];
            
            
            
            
            UIButton *Button3 = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell.contentView  addSubview:Button3];
            [Button3 addTarget:self action:@selector(aftermovie) forControlEvents:UIControlEventTouchUpInside];
            Button3.frame = CGRectMake(0, 485, 320, 200);
            Button3.backgroundColor = [UIColor clearColor];
                       _imgView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 485, 320, 200)];
                       [cell.contentView addSubview:_imgView1];
            
            
            
            
            
            
            _animatedLabel = [[ATLabel alloc] initWithFrame:CGRectMake(10, 417, 320, 100)];
            [_animatedLabel animateWithWords:@[
                                               @"Festival Map",
                                               @"Downend, Isle Of Wight"
                                               
                                               ]
                                 forDuration:8.0f
                               withAnimation:ATAnimationTypeFadeInOut];
            
            
            _animatedLabel.font =[UIFont fontWithName:@"Avenir-medium" size:12];
            [cell.contentView addSubview:_animatedLabel];
            
            
            _animatedLabel2 = [[ATLabel alloc] initWithFrame:CGRectMake(10, 590, 320, 100)];
            [_animatedLabel2 animateWithWords:@[
                                                @"Aftermovie",
                                                @"Desert Island Disco Official "
                                                
                                                
                                                ]
                                  forDuration:5.0f
                                withAnimation:ATAnimationTypeFadeInOut];
            
            
            _animatedLabel2.font =[UIFont fontWithName:@"Avenir-Black" size:15];
            _animatedLabel2.textColor=[UIColor whiteColor];
            [cell.contentView addSubview:_animatedLabel2];
            
            
            _animatedLabel2 = [[ATLabel alloc] initWithFrame:CGRectMake(10, 590, 320, 100)];
            

            
    
            UIButton *Button4 = [UIButton buttonWithType:UIButtonTypeCustom];
            [Button4 setTitle:@"EXPLORE" forState:UIControlStateNormal];
            Button4.titleLabel.font =[UIFont fontWithName:@"AvenirNext-UltraLight" size:70];
            [cell.contentView  addSubview:Button4];
            [Button4 addTarget:self action:@selector(showInstagramFeed) forControlEvents:UIControlEventTouchUpInside];
            Button4.frame = CGRectMake(0, 805, 320, 80);
            Button4.backgroundColor = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1];
            
            
            
            
            
            
        }
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:CONTENT_IMAGE_VIEW_TAG];
            imageView.image = [UIImage imageNamed:@"best-content.png"];
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
  
    instagram.instagramUserId = @"42067004"; //if you want request the feed of one user
    instagram.instagramMultipleDefaultAccessToken = @[@"6874212.436eb0b.9768fd326f9b423eab7dd260972ee6db",@"6874212.039e67c.ac264aaa9ba44f40b7c4fe2729772063"];
    
    //both are optional, but if you need search by tag you need set both
    //instagram.isSearchByTag = YES; //if you want serach by tag
    //instagram.searchTag = @"colombia"; //search by tag query
    

    
    instagram.instagramMultipleTags = @[@"bestival",@"bestival2014",@"bestival2015"]; //if you set this you don't need set isSearchByTag in true
    
    //instagram.showOnePicturePerRow = YES; //to change way to show the feed, one picture per row(default = NO)
    
    //instagram.showSwitchModeView = YES; //show a segment controller with view option (default = NO)
    
    instagram.loadingImageName = @"loading.jpg"; //config a custom loading image
    instagram.videoPlayImageName = @"SBInsta_play"; //config a custom video play image
    instagram.videoPauseImageName = @"SBInsta_pause"; //config a custom video pause image
    instagram.playStandardResolution = YES; //if you want play a standard resuluton, low resolution per default
    
    [instagram refreshCollection2]; //refresh instagram feed
    
    //push instagram view controller into navigation
    [self presentViewController: instagram.feed animated:YES completion:nil];
            [Flurry logEvent:@"Explore instragram-BESTIVAL"];
}


- (void)buttonPressed:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
    [Flurry logEvent:@"Back to main menu button- bestival"];
    
}



-(void)lineup {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.bestival.net/"]];
    [controller showFromController:self];
    
    [Flurry logEvent:@"LINEUP- bestival"];
    
}
-(void)ticket {

    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://2014.bestival.net/info"]];
    [controller showFromController:self];
    
    
    [Flurry logEvent:@"ticket- bestival"];
}
-(void)aftermovie {
    
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"pLXolUMyk48"];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
    [Flurry logEvent:@"aftermovie- bestival"];
}
-(void)facebook {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://www.facebook.com/bestivalfestival"]];
    [controller showFromController:self];
    [Flurry logEvent:@"facebook- bestival"];
}
-(void)twitter {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://twitter.com/bestival"]];
 [controller showFromController:self];
        [Flurry logEvent:@"twitter- bestival"];
}



- (void)map
{
    GoogleMapViewConttlloerViewController *google=[[GoogleMapViewConttlloerViewController alloc] initWithNibName:@"GoogleMapViewConttlloerViewController" bundle:nil];
    
    google.codinate = CLLocationCoordinate2DMake(50.683516,-1.233602) ;
    google.codinate1 = CLLocationCoordinate2DMake(50.683516,-1.233602) ;
    
    
    [self presentViewController:google animated:YES completion:nil];
}



@end
