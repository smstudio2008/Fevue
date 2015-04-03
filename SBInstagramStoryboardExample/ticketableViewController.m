//
//  ticketableViewController.m
//  fevue
//
//  Created by SALEM on 25/01/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//

#import "ticketableViewController.h"
#import "bestivalViewController.h"
#import "VBFPopFlatButton.h"
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "creamticViewController.h"
#import "secreticViewController.h"
#import "isleticketViewController.h"
#import "ParkticViewController.h"
#import "tinparkticViewController.h"
#import "glasticViewController.h"
#import "vfestticViewController.h"
#import "fstvlticViewController.h"
#import "glasticViewController.h"
#import "wireticViewController.h"
#import "TOMTICViewController.h"
#import "hideTicViewController.h"
// Table cells
#import "JBParallaxCell.h"

@interface ticketableViewController () <UIScrollViewDelegate,UITableViewDelegate>
{
    VBFPopFlatButton *_flatRoundedButton;
}

    
@property(nonatomic,strong) NSArray *imagesArray;

@property (nonatomic, strong) NSArray *tableItems;

@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;

@property (nonatomic, strong) NSTimer *workTimer;




@end

@implementation ticketableViewController


@synthesize festivalTable;


@synthesize workTimer = _workTimer;



- (void)statTodoSomething {
    
    [self.workTimer invalidate];
    
    self.workTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onAllworkDoneTimer) userInfo:nil repeats:NO];
}

- (void)onAllworkDoneTimer {
    [self.workTimer invalidate];
    self.workTimer = nil;
    
    [self.festivalTable reloadData];
}



- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    

    [self queryParseMethod];

    
    UILabel *nav_titlelbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.navigationItem.titleView.frame.size.width,40)];
    nav_titlelbl.text=@"TICKETS";
    
    nav_titlelbl.textAlignment=NSTextAlignmentLeft;
    
    UIFont *lblfont=[UIFont fontWithName:@"DINAlternate-Bold" size:22];
    [nav_titlelbl setFont:lblfont];
   nav_titlelbl.textColor = [UIColor whiteColor];
    
    
    self.navigationItem.titleView=nav_titlelbl;
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(17, 10, 20, 20)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    
    
    
    [self.navigationController.navigationBar addSubview:_flatRoundedButton];
    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(35, 0, 70, 40)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonPlainStyle
                                          animateToInitialState:NO];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 20;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.navigationController.navigationBar addSubview:_flatRoundedButton];

    
    
    
    
        
    
    
    [self performSelector:@selector(retrieveFromParse)];
        [self.view setBackgroundColor:[UIColor blackColor]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}




- (void)refreshTriggered {
    [self statTodoSomething];
}



- (void)viewDidAppear:(BOOL)animated
{
    

    
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:nil];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void) retrieveFromParse {
    PFQuery *retrieveheadlines = [PFQuery queryWithClassName:@"festivalPricetable"];
    [retrieveheadlines findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            maintitles = [[NSArray alloc] initWithArray:objects];
        }
        
        [festivalTable reloadData];
        
        
    }];
    
}


- (void)queryParseMethod {
    PFQuery *query3 = [PFQuery queryWithClassName:@"festivalPricetable"];
    
    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             //            PFObject *objFollow1 = [objects objectAtIndex:1];
             //            PFFile *image = [objFollow1 objectForKey:@"imageData"];
             
             self.imagesArray = objects ;
             
             [festivalTable reloadData];
             
             //            NSLog(@"%@",image.url);
             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.imagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"parallaxCell";
    JBParallaxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
       PFObject *tempObject = [maintitles objectAtIndex:indexPath.row];
    
    
    
cell.festivallabel.text =[tempObject objectForKey:@"festivalName"];
    cell.subtitleLabel.text =[tempObject objectForKey:@"festivalDate"];
    cell.titleLabel.text =[tempObject objectForKey:@"festivalPrice"];
    
    
      PFFile *image = [[self.imagesArray objectAtIndex:indexPath.row] objectForKey:@"festivalImage"];
              
[cell.parallaxImage sd_setImageWithURL:[NSURL URLWithString:image.url]];
    

    
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.festivalTable visibleCells];
    
    for (JBParallaxCell *cell in visibleCells)
    {
        [cell cellOnTableView:self.festivalTable didScrollOnView:self.view];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    if (indexPath.row == 0) {
       
              [self.navigationController pushViewController:[[fstvlticViewController alloc] init] animated:YES];
         [Flurry logEvent:@"TICKETS view- FSTVL "];
        
    }else if (indexPath.row == 1) {
      [self.navigationController pushViewController:[[ParkticViewController   alloc] init] animated:YES];
              [Flurry logEvent:@"TICKETS view- PARKLIFE"];
    }else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[[isleticketViewController alloc] init] animated:YES];
              [Flurry logEvent:@"TICKETS view- ISLE OF WIGHT "];
        
            }else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[[glasticViewController alloc] init] animated:YES];
        [Flurry logEvent:@"TICKETS view- GLASTONBURY "];
                
            }else if (indexPath.row == 4) {
  [self.navigationController pushViewController:[[hideTicViewController alloc] init] animated:YES];
                     [Flurry logEvent:@"TICKETS view- HIDEOUT "];
                }else if (indexPath.row == 5) {
       [self.navigationController pushViewController:[[wireticViewController alloc] init] animated:YES];
                     [Flurry logEvent:@"TICKETS view- WIRELESS "];
            }else if (indexPath.row == 6) {
        [self.navigationController pushViewController:[[ tinparkticViewController alloc] init] animated:YES];
     [Flurry logEvent:@"TICKETS view- TINTHEPARK"];
            }else if (indexPath.row == 7) {
     [self.navigationController pushViewController:[[secreticViewController alloc] init] animated:YES];
        [Flurry logEvent:@"TICKETS view- SECRET GARDEN"];
                    }else if (indexPath.row == 8) {
                [self.navigationController pushViewController:[[TOMTICViewController alloc  ] init] animated:YES];
          [Flurry logEvent:@"TICKETS view- TOMORROWLAND"];
                    }else if (indexPath.row == 9) {
       [self.navigationController pushViewController:[[vfestticViewController alloc  ] init] animated:YES];
                          [Flurry logEvent:@"TICKETS view- V FESTIVAL"];
    }else if (indexPath.row == 10) {
[self.navigationController pushViewController:[[creamticViewController alloc] init] animated:YES];
         [Flurry logEvent:@"TICKETS view- CREAMFIELD"];
            }else if (indexPath.row == 11) {
                [self.navigationController pushViewController:[[bestivalViewController alloc] init] animated:YES];
 [Flurry logEvent:@"TICKETS view- BESTIVAL"];
}

    
}
- (void)buttonPressed:(id)sender {
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end


