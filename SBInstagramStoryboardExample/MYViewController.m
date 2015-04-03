//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import "MYViewController.h"
#import "JBWebViewController.h"
#import "Flurry.h"
#import "VBFPopFlatButton.h"


@interface MYViewController ()


@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@end

@implementation MYViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: _flatRoundedButton];
    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 34, 55, 55)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: _flatRoundedButton];
    
    
        
}

-(void)viewDidAppear:(BOOL)animated{
    //Calling this methods builds the intro and adds it to the screen. See below.
    [self buildIntro];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Build MYBlurIntroductionView

-(void)buildIntro{
    //Create Stock Panel with header
    
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"ABOUT" description:@"Fevue was launched in 2014 by festival enthusiast on a mission to enable people to discover the ultimate festival destination " image:[UIImage imageNamed:@"HeaderImage.png"]];
    
    //Create Stock Panel With Image
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"FEVUE" description:@"Fevue wants to make it easier for festival lovers to do what they love : Rave, Share and Repeat" image:[UIImage imageNamed:@"HeaderImage.png"]];
    
    
    //Add panels to an array
    NSArray *panels = @[panel1, panel2];
    
    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"girl.jpg"];
    [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];
}

#pragma mark - MYIntroduction Delegate

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{

    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:0.65]];
    }
}



- (void)buttonPressed:(id)sender {
    
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
}


- (IBAction)facebook:(id)sender {
    
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://www.facebook.com/fevue"]];
    
    [controller show];
    
    [Flurry logEvent:@"Fevue About-  Facebook like"];
}


- (IBAction)twiiter:(id)sender {
    
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://twitter.com/FevueApp"]];
    [controller show];
    [Flurry logEvent:@"Fevue About-  twitter follow"];
}

- (IBAction)instagram:(id)sender {
    
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://instagram.com/fevue/"]];
    
    [controller show];
    [Flurry logEvent:@"Fevue About-  instagram follow"];}



@end
