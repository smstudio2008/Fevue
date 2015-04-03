//
//  vfestViewController.m
//  fevue
//
//  Created by SALEM on 28/01/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//

#define SIMPLE_SAMPLE YES


#import "fstvlticViewController.h"
#import "Flurry.h"

@interface fstvlticViewController ()

@end

@implementation fstvlticViewController


{
    BTGlassScrollView *_glassScrollView;
    UIScrollView *_viewScroller;


    int _page;
    
}

- (void)viewDidLoad
{
    
    //showing white status
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    
    //navigation bar work
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1, 1)];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowBlurRadius:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSShadowAttributeName: shadow};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
    //background
    self.view.backgroundColor = [UIColor blackColor];
    
    //#warning Toggle this to see the more complex build of this version
    if (SIMPLE_SAMPLE) {
        //create your custom info views
        UIView *view = [self customView];
        
        _glassScrollView =[[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"weare-tic.jpg"] blurredImage:nil viewDistanceFromBottom:120 foregroundView:view];
        
        [self.view addSubview:_glassScrollView];
        
    }
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(25, 30, 20, 20)
                                                     buttonType:buttonBackType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:_flatRoundedButton];
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 30, 40, 40)
                                                     buttonType:buttonBackType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:_flatRoundedButton];
    
    
    
    
    
    
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    

    
    
    
}




- (void)viewWillAppear:(BOOL)animated
{
   
    
        if (!SIMPLE_SAMPLE) {
        int page = _page; // resize scrollview can cause setContentOffset off for no reason and screw things up
        
        CGFloat blackSideBarWidth = 2;
        [_viewScroller setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
        [_viewScroller setContentSize:CGSizeMake(1*_viewScroller.frame.size.width, self.view.frame.size.height)];
        


        
        [_viewScroller setContentOffset:CGPointMake(page * _viewScroller.frame.size.width, _viewScroller.contentOffset.y)];
        _page = page;
    }
    
    //show animation trick
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // [_glassScrollView1 setBackgroundImage:[UIImage imageNamed:@"background"] overWriteBlur:YES animated:YES duration:1];
    });
}

- (void)viewWillLayoutSubviews
{
    // if the view has navigation bar, this is a great place to realign the top part to allow navigation controller
    // or even the status bar
    if (SIMPLE_SAMPLE) {
        [_glassScrollView setTopLayoutGuideLength:[self.topLayoutGuide length]];



    }
}

- (UIView *)customView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 905)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 120)];
    [label setText:[NSString stringWithFormat:@"SEARCH"]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(1, 1)];
    [view addSubview:label];
    
    UIView *box1 = [[UIView alloc] initWithFrame:CGRectMake(5, 140, 310, 120)];
    box1.layer.cornerRadius = 3;
    box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.25];
    
    
    
    
    CGRect frame = CGRectMake(32, 70, 240, 50);
    HTPressableButton *rectButton = [[HTPressableButton alloc] initWithFrame:frame buttonStyle:HTPressableButtonStyleRect];
    rectButton.buttonColor = [UIColor ht_pomegranateColor];
    rectButton.shadowColor =  [UIColor clearColor];
    [rectButton setTitle:@"Book" forState:UIControlStateNormal];
    rectButton.titleLabel.font =[UIFont fontWithName:@"Avenir-Book" size:21];
    [rectButton addTarget:self action:@selector(festivalPrice) forControlEvents:UIControlEventTouchUpInside];
    [box1  addSubview:rectButton];
    
    
    
    
    _bestivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 300, 50)];
    
    _bestivalLabel.textColor = [UIColor whiteColor];
    _bestivalLabel.textAlignment = NSTextAlignmentCenter;
    _bestivalLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:35];
    _bestivalLabel.text = @"WE ARE FSTVL ";
    
    [box1  addSubview:_bestivalLabel];
    
    _bestivalLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 32, 300, 50)];
    
    _bestivalLabel1.textColor = [UIColor whiteColor];
    _bestivalLabel1.textAlignment = NSTextAlignmentCenter;
    _bestivalLabel1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:15];
    _bestivalLabel1.text = @"OFFICIAL WEBSITE ";
    
    [box1  addSubview:_bestivalLabel1];
    
    [view addSubview:box1];
    
    UIView *box2 = [[UIView alloc] initWithFrame:CGRectMake(5, 270, 310, 225)];
    box2.layer.cornerRadius = 3;
    box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.25];
    [view addSubview:box2];
    
    _tickets = [[UILabel alloc] initWithFrame:CGRectMake(105, 12, 100, 20)];
    
    _tickets.textColor = [UIColor whiteColor];
    _tickets.textAlignment = NSTextAlignmentCenter;
    _tickets.font = [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:15];
    _tickets.text = @"TICKET AGENTS ";
    
    [box2  addSubview: _tickets];
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"  " forState:UIControlStateNormal];
    button.frame = CGRectMake(5, 40, 300, 35);
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [[UIColor whiteColor]CGColor];
    [button addTarget:self action:@selector(searchPrice1) forControlEvents:UIControlEventTouchUpInside];
    [box2 addSubview:button];
    
    
    _price = [[UILabel alloc] initWithFrame:CGRectMake(12, 45, 300, 30)];
    
    _price.textColor = [UIColor whiteColor];
    _price.textAlignment = NSTextAlignmentLeft;
    _price.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    _price.text = @"VIAGAGO.CO.UK                              £56.00- £ 105.00 ";
    
    [box2  addSubview:  _price];
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"  " forState:UIControlStateNormal];
    button1.frame = CGRectMake(5, 80, 300, 35);
    button1.layer.borderWidth = 0.5;
    button1.layer.borderColor = [[UIColor whiteColor]CGColor];
    [button1 addTarget:self action:@selector(searchPrice2) forControlEvents:UIControlEventTouchUpInside];
    [box2 addSubview:button1];
    
    
    
    _price1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 85, 300, 30)];
    
    _price1.textColor = [UIColor whiteColor];
    _price1.textAlignment = NSTextAlignmentLeft;
    _price1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    _price1.text =  @"STUBHUB                                        £59.00- £ 129.00 ";
    
    [box2  addSubview:  _price1];
    
    
    
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"  " forState:UIControlStateNormal];
    button2.frame = CGRectMake(5, 120, 300, 35);
    button2.layer.borderWidth = 0.5;
    button2.layer.borderColor = [[UIColor whiteColor]CGColor];
    [button2 addTarget:self action:@selector(searchPrice3) forControlEvents:UIControlEventTouchUpInside];
    [box2 addSubview:button2];
    
    
    
    _price2 = [[UILabel alloc] initWithFrame:CGRectMake(12, 125, 300, 30)];
    
    _price2.textColor = [UIColor whiteColor];
    _price2.textAlignment = NSTextAlignmentLeft;
    _price2.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    _price2.text = @"GETME-IN                                       £82.00- £ 143.00 ";
    
    [box2  addSubview:  _price2];
    
    
    
    
    
    UIView *box3 = [[UIView alloc] initWithFrame:CGRectMake(5, 505, 310, 390)];
    box3.layer.cornerRadius = 3;
    box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:box3];
    
    _tickets1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 12, 150, 20)];
    
    _tickets1.textColor = [UIColor whiteColor];
    _tickets1.textAlignment = NSTextAlignmentCenter;
    _tickets1.font = [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:15];
    _tickets1.text = @"FESTIVAL PACKAGE ";
    
    [box3  addSubview: _tickets1];
    
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button4 setTitle:@"COMING SOON  " forState:UIControlStateNormal];
    button4.frame = CGRectMake(5, 45, 300, 150);
    button4.layer.borderWidth = 1.5;
    button4.layer.borderColor = [[UIColor whiteColor]CGColor];
    [box3 addSubview:button4];
    
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button5 setTitle:@"COMING SOON  " forState:UIControlStateNormal];
    button5.frame = CGRectMake(5, 205, 300, 150);
    button5.layer.borderWidth = 1.5;
    button5.layer.borderColor = [[UIColor whiteColor]CGColor];
    [box3 addSubview:button5];
    
    
    
        return view;
}



- (BTGlassScrollView *)currentGlass
{
    BTGlassScrollView *glass;
    switch (_page) {
        case 0:


        default:
            break;
    }
    return glass;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self viewWillAppear:YES];
}

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)festivalPrice {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.wearefstvl.com/tickets"]];
    [controller showFromController:self];
      [Flurry logEvent:@"ticket- wearefstvl-website-www.wearefstvl.com"];
}



-(void)searchPrice1 {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.viagogo.co.uk/Festival-Tickets/UK-Festivals/We-Are-FSTVL-Tickets"]];
    [controller showFromController:self];
   [Flurry logEvent:@"ticket- wearefstvl-website-www.viagogo.co.uk"];
    
}

-(void)searchPrice2 {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.stubhub.co.uk/search/doSearch?searchStr=we+are+fstvl&searchMode=event&rows=50&start=0&nS=0&ae=1&sp=Date&sd=1&category=732823;We+are+FST"]];
    [controller showFromController:self];
   [Flurry logEvent:@"ticket- wearefstvl-website-http://www.stubhub.co.uk"];
    
}

-(void)searchPrice3 {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.getmein.com/festivals/we-are-fstvl-tickets.html"]];
    [controller showFromController:self];
      [Flurry logEvent:@"ticket- wearefstvl-website-www.getmein.com"];
}
















@end