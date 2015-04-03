//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//


#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbackground.jpg"]]];
    

    
    
    self.logInView.logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"new-logo.png"]];
    
    // Set buttons appearance
    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateHighlighted];
    
    
    [self.logInView.facebookButton setImage: nil forState:UIControlStateNormal];
    [self.logInView.facebookButton setImage: nil forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage: [UIImage imageNamed: @""] forState: UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage: [UIImage imageNamed: @"facebooklogin.png"] forState: UIControlStateNormal];
    [self.logInView.facebookButton setTitle: @"" forState: UIControlStateNormal];
    [self.logInView.facebookButton setTitle: @"" forState: UIControlStateHighlighted];
    
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 435, 300, 60)];
    
    [yourLabel setTextColor:[UIColor whiteColor]];
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    [yourLabel setFont:[UIFont fontWithName: @"Avenir-Heavy" size: 11.0f]];
  yourLabel.text= @"Sign-up with Facebook";
    
    [self.logInView addSubview:yourLabel];

    UILabel *yourLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 295, 320, 60)];
    
    [yourLabel1 setTextColor:[UIColor whiteColor]];
    [yourLabel1 setBackgroundColor:[UIColor clearColor]];
    [yourLabel1 setFont:[UIFont fontWithName: @"Avenir-Heavy" size: 18.0f]];
    yourLabel1.text= @"Discover your Ultimate ";
    
    [self.logInView addSubview:yourLabel1];
    
    
        UILabel *yourLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(73, 320, 320, 60)];
    [yourLabel2 setTextColor:[UIColor whiteColor]];
    [yourLabel2 setBackgroundColor:[UIColor clearColor]];
    [yourLabel2 setFont:[UIFont fontWithName: @"Avenir-Heavy" size: 18.0f]];
    yourLabel2.text= @"Festival Destination";
    
    [self.logInView addSubview:yourLabel2];
    
    
    

}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    double
    buttonsMargins = self.view.frame.size.width / 9;
    
self.logInView.facebookButton.frame = CGRectMake(buttonsMargins, 400, 250, 55);
[self.logInView.dismissButton setFrame:CGRectMake(280.0f, 23.0f, 20.f, 20.5f)];
    
    [self.logInView.logo setFrame:CGRectMake(130.f, 120.f, 110.0f, 180)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end