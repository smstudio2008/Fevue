//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "LocationViewController.h"
#import "GlobalClass.h"
#import "TaggableFriendCell.h"
#import  <Parse/Parse.h>

@interface LocationViewController ()
{
    IBOutlet UITableView *tblView;
    
    NSMutableArray *arryDateList;
}
@end

@implementation LocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"LocationsAndDays" ofType:@"plist"];
    
    arryDateList=[[NSMutableArray alloc]initWithContentsOfFile:path];
    
    PFQuery *query3 = [PFQuery queryWithClassName:@"inviteFriendbackground"];
    
    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             //            PFObject *objFollow1 = [objects objectAtIndex:1];
             //            PFFile *image = [objFollow1 objectForKey:@"imageData"];
             
             self.locations = objects ;
             
             [tblView reloadData];
             
             //            NSLog(@"%@",image.url);
             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.selectableFriends.count;
    return self.locations.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaggableFriendCell *cell = [tableView dequeueReusableCellWithIdentifier: @"locationCell" forIndexPath: indexPath];
    
    //    cell.friendName.text =
    //    [[self.locations objectAtIndex:indexPath.row]valueForKey:@"locationName"];
    
    cell.friendName.text = [[self.locations objectAtIndex:indexPath.row] objectForKey:@"imageName"];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // [self.delegate friendSelected: self.selectableFriends[indexPath.row]];
    //    [GlobalClass sharedObject].imageName=[[self.locations objectAtIndex:indexPath.row]valueForKey:@"imageName"];
    
    [GlobalClass sharedObject].isLocationSelected=YES;
    
    [GlobalClass sharedObject].date=[[arryDateList objectAtIndex:indexPath.row]valueForKey:@"date"];
    
    PFFile *image = [[self.locations objectAtIndex:indexPath.row] objectForKey:@"imageData"];
    
    [GlobalClass sharedObject].imageName= image.url;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end