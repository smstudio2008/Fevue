//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "SettingsScreenController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "SKProgressIndicator.h"
#import "SBAppDelegate.h"
#import "JBWebViewController.h"
#import "Flurry.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>


@implementation SettingsScreenController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *nav_titlelbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.navigationItem.titleView.frame.size.width,40)];
    nav_titlelbl.text=@"SETTING";
    
    nav_titlelbl.textAlignment=NSTextAlignmentLeft;
    
    UIFont *lblfont=[UIFont fontWithName:@"DINAlternate-Bold" size:22];
    [nav_titlelbl setFont:lblfont];
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
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(25, 10, 55, 55)
                                                     buttonType:buttonMenuType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor clearColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor clearColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    [self.navigationController.navigationBar addSubview:_flatRoundedButton];
    
    
    
    
    
    
    
    
    
    UIGraphicsBeginImageContext(self.tableView.frame.size);
    [[UIImage imageNamed:@"settingbackground.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:image];
    

    
    if ([PFUser currentUser]) {
        if ([PFTwitterUtils isLinkedWithUser: [PFUser currentUser]]) {
            self.profileImage=nil;
        } else if ([PFFacebookUtils isLinkedWithUser: [PFUser currentUser]]) {
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSString *displayName = result[@"name"];
                    
                    if (displayName) {
                        self.name=displayName;
                        NSString *imageUrlString = [NSString stringWithFormat: @"http://graph.facebook.com/%@/picture?type=large", result[@"id"]];
                        NSURL *imageUrl = [NSURL URLWithString: imageUrlString];
                        NSURLSession *mainQueueSession = [NSURLSession sessionWithConfiguration: nil delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                        NSURLSessionDataTask *imageQueryTask = [mainQueueSession dataTaskWithURL: imageUrl
                                                                               completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                                   UIImage *responseImage = nil;
                                                                                   
                                                                                   if (error == nil) {
                                                                                       responseImage = [UIImage imageWithData: data];
                                                                                       
                                                                                       self.profileImage=responseImage;
                                                                                       [_tableView reloadData];                                                        }
                                                                               }];
                        [imageQueryTask resume];
                    }
                }
            }];
        } else {
            self.profileImage=nil;
        }
    }
    
    // MARK
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""]
                                                                             style: UIBarButtonItemStylePlain
                                                                            target: self
                                                                            action: @selector(showMenu)];
    
    typeof(self) bself = self;
    self.phSwipeHander = ^{
        [bself showMenu];
    };
    
}
- (void)showMenu {
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.section==0)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section1Cell"];
        UILabel *profileName=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, 300, 30)];
        profileName.text=self.name;
        profileName.textColor=[UIColor blackColor];
        profileName.textAlignment=NSTextAlignmentCenter;
        UIImageView *profileImageView=[[UIImageView alloc]initWithFrame:CGRectMake(110, 10, 100, 100)];
        profileImageView.image=self.profileImage;

        
        [cell.contentView addSubview:profileImageView];
        [cell.contentView addSubview:profileName];
    }
    else if(indexPath.section==1)
    {
        
        // Declare the view controller
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section2Cell"];
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"Term & Conditions";
                cell.textLabel.font =[UIFont fontWithName:@"Avenir-medium" size:15];
                  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                break;
            case 1:
                cell.textLabel.text=@"Privacy policy ";
                cell.textLabel.font =[UIFont fontWithName:@"Avenir-medium" size:15];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                
                
                
                
                break;
            case 2:
                cell.textLabel.text=@"Promote your Festival";
                cell.textLabel.font =[UIFont fontWithName:@"Avenir-medium" size:15];
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                break;
            case 3:
                cell.textLabel.text=@"Help";
                cell.textLabel.font =[UIFont fontWithName:@"Avenir-medium" size:15];
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                
                break;
                
        }
    }
    else
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section3Cell"];
        UIView *cellView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UILabel *signOut=[[UILabel alloc]initWithFrame:CGRectMake(12, 8, 180, 30)];
        signOut.text=@"SIGN OUT";
        signOut.font =[UIFont fontWithName:@"Avenir-Heavy" size:15];
        UISwitch *signSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(250, 5, 100, 30)];
        [signSwitch addTarget:self action:@selector(signOutSwitch) forControlEvents:UIControlEventValueChanged];
        [cellView addSubview:signOut];
        [cellView addSubview:signSwitch];
        [cell.contentView addSubview:cellView];
        
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 &&
        indexPath.row == 0) {
        JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://fevue.com/services"]];
        [controller show];
        [Flurry logEvent:@"twitter- Tomorrowland"];
    }
    if (indexPath.section == 1 &&
        indexPath.row == 1) {
        JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.fevue.com/policy"]];
        [controller show];
        [Flurry logEvent:@"twitter- Tomorrowland"];
    }
    
        if (indexPath.section == 1 &&
            indexPath.row == 2) {
            JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.fevue.com/promote"]];
            [controller show];
            [Flurry logEvent:@"twitter- Tomorrowland"];
        }
    
    if (indexPath.section == 1 &&
        indexPath.row == 3) {
        JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.fevue.com"]];
        [controller show];
        [Flurry logEvent:@"twitter- Tomorrowland"];
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 44;
            break;
        default:
            return 44;
            break;
    }
}


- (void)signOutSwitch {
    [PFUser logOut];
    self.profileImage =nil;
    self.name = @"";
    
    [self.tableView reloadData];
    
    
    NSIndexPath *feedControllerIndexPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
    UIViewController *feedController = [self.airViewController getViewControllerAtIndexPath: feedControllerIndexPath];
    [self.airViewController switchToViewController: feedController atIndexPath: feedControllerIndexPath];
}


- (void)buttonPressed:(id)sender {
    
    [self.airViewController showAirViewFromViewController: self.navigationController complete: nil];
}

-(void)twitter {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://twitter.com/bestival"]];
    [controller show];
    
}






@end
