//
//  diceViewController.m
//  fevue
//
//  Created by SALEM on 28/01/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//

#import "diceViewController.h"
#import "VBFPopFlatButton.h"


@interface diceViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property (nonatomic, strong)NSArray *animations;

@end

@implementation diceViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];    
    
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
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(25, 10, 70, 45)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonPlainStyle
                                          animateToInitialState:NO];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 20;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_flatRoundedButton];
    

    
    
    
    
    
    
    
    
    
    
    
    // Example of changing the feature height and collapsed height for all
    //self.featureHeight = 200.0f;
    //self.collapsedHeight = 100.0f;
}


#pragma mark - RPSlidingMenuViewController


-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 16;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    if (row == 0) {
         slidingMenuCell.textLabel.text = @"BESTIVAL";
         slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
          slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"bestival-main.jpg"];
    }
    
    
    if (row == 1) {
        slidingMenuCell.textLabel.text = @"CREAMSFIELD";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:40];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"cream-main.jpg"];
    }
    
    
    if (row == 2) {
        slidingMenuCell.textLabel.text = @"ISLE OF WIGHT";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"isle-main.jpg"];
    }
    
    
    if (row == 3) {
         slidingMenuCell.textLabel.text = @"SECRET GARDEN PARTY";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:35];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"sec-main.jpg"];
    }
    
    
    if (row == 4) {
         slidingMenuCell.textLabel.text = @"PARKLIFE";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"park-main.jpg"];
    }
    
    
    
    if (row == 5) {
        slidingMenuCell.textLabel.text = @"T IN THE PARK";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
         slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"t-main.jpg"];
    }
    
    
    if (row == 6) {
        slidingMenuCell.textLabel.text = @"GLASTONBURY";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
         slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"gla-main.jpg"];
    }
    
    
    if (row == 7) {
        slidingMenuCell.textLabel.text = @"V FESTIVAL";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"vf-main.jpg"];
    }
    
    
    if (row == 8) {
        slidingMenuCell.textLabel.text = @"WE ARE FSTVL";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"we-main.jpg"];
    }
    
    
    
    if (row == 9) {
        slidingMenuCell.textLabel.text = @"WIRELESS";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"UNITED KINDGOM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];

        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"wires-main.jpg"];
    }
    
    
    if (row == 10) {
        slidingMenuCell.textLabel.text = @"DEFQON 1";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"NETHERLAND";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
         slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"deq-main.jpg"];
    }
    
    
    if (row == 11) {
        slidingMenuCell.textLabel.text = @"HIDEOUT";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"CROATIA";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"hideout-main.jpg"];
    }
    
    
    if (row == 12) {
        slidingMenuCell.textLabel.text = @"HOLI FESTIVAL OF COLOUR";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:30];
        slidingMenuCell.detailTextLabel.text = @"GERMANY";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
       slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"hol-main.jpg"];
    }
    
    if (row == 13) {
        slidingMenuCell.textLabel.text = @"MYSTERLAND";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:45];
        slidingMenuCell.detailTextLabel.text = @"NETHERLAND";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"mys-mains.jpg"];
    }
    
    
    if (row == 14) {
        slidingMenuCell.textLabel.text = @"TOMORROWLAND";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:42];
        slidingMenuCell.detailTextLabel.text = @"BELGUIM";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"tomrow-main.jpg"];
    }
    
    
    if (row == 15) {
        slidingMenuCell.textLabel.text = @"COACHELLA";
        slidingMenuCell.textLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:42];
        slidingMenuCell.detailTextLabel.text = @"U.S.A";
        slidingMenuCell.detailTextLabel.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:10];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"coach.jpg"];
    }
    
    
    
    
    
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    if (row == 0) {
              UIViewController *google=[[bestivalController alloc] init];
        [self presentViewController:google animated:YES completion:nil];
                   [Flurry logEvent:@"festival menu  - Bestival Festival "];
}

    if (row == 1) {
        // when a row is tapped do some action
        UIViewController *google=[[creamViewController alloc] init];
           [self presentViewController:google animated:YES completion:nil];
       [Flurry logEvent:@"festival menu  - Creamfield Festival "];
    }
    
     if (row == 2) {
        // when a row is tapped do some action
         UIViewController *google=[[isleViewController alloc] init];
         [self presentViewController:google animated:YES completion:nil];
          [Flurry logEvent:@"festival menu  - Isle of wight Festival "];
     
     }
    
    if (row == 3) {
 
        UIViewController *google=[[SgpViewController  alloc] init];
        [self presentViewController:google animated:YES completion:nil];
          [Flurry logEvent:@"festival menu  - SGP  Festival "];
        
        }
    
    if (row == 4) {
        // when a row is tapped do some action
        
        UIViewController *google=[[SonViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
         [Flurry logEvent:@"festival menu  - Parklife Festival "];
        
             }
    
    if (row == 5) {
        // when a row is tapped do some action
    
        UIViewController *google=[[tintheparkViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
         [Flurry logEvent:@"festival menu  -T IN THE PARK Festival "];
        
        }
        if (row == 6) {
        // when a row is tapped do some action
        UIViewController *google=[[glastonbury   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
                [Flurry logEvent:@"festival menu  -Glasonbury  Festival "];
    }
    
    
    if (row == 7) {
        // when a row is tapped do some action
        
        
        UIViewController *google=[[vfestViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
          [Flurry logEvent:@"festival menu  -  V Festival "];

    }
    
    if (row == 8) {
        // when a row is tapped do some action
        
        
        UIViewController *google=[[fstvlViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
          [Flurry logEvent:@"festival menu  -  WE ARE FSTVL "];
        
        }
    
    if (row == 9) {
        // when a row is tapped do some action
        UIViewController *google=[[wirelessViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
          [Flurry logEvent:@"festival menu  -  WIRELESS Festival "];
        
        }
    
    if (row == 10) {
        // when a row is tapped do some action

        UIViewController *google=[[defqon1ViewController    alloc] init];
        [self presentViewController:google animated:YES completion:nil];
         [Flurry logEvent:@"festival menu  -  DEFQON 1 Festival "];

        
    }
    
    if (row == 11) {
        // when a row is tapped do some action
        UIViewController *google=[[ hideoutViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
                 [Flurry logEvent:@"festival menu  -  HIDEOUT Festival "];
        
    }
    
    if (row == 12) {
        // when a row is tapped do some action

        UIViewController *google=[[ holiViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
               [Flurry logEvent:@"festival menu  -  HOLI OF COLOUR Festival "];
        
         }
    
    
    if (row == 13) {
        // when a row is tapped do some action
        UIViewController *google=[[ mysterViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
               [Flurry logEvent:@"festival menu  -  MYSTERLAND Festival "];
        
    }
    if (row == 14) {
        // when a row is tapped do some action

        UIViewController *google=[[ tomViewController    alloc] init];
        [self presentViewController:google animated:YES completion:nil];
          [Flurry logEvent:@"festival menu  -  TOMORROW Festival "];        
    }
    
    if (row == 15) {
        // when a row is tapped do some action
        
        UIViewController *google=[[ coachellaViewController   alloc] init];
        [self presentViewController:google animated:YES completion:nil];
        [Flurry logEvent:@"festival menu  -  TOMORROW Festival "];
    }
    
    
    
    
    
    
    
    
}

- (void)buttonPressed:(id)sender {
      [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
         [self dismissViewControllerAnimated:YES completion:nil];
}





@end
