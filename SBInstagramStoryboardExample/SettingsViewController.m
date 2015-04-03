//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>


@implementation SettingsViewController
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
    }
    else if(indexPath.section==1)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section2Cell"];
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"About";
                
                break;
            case 1:
                cell.textLabel.text=@"Feedback";
                      
                break;

            
        }
    }
    else
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section3Cell"];
        UIView *cellView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UILabel *signOut=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 180, 30)];
        signOut.text=@"Sign Out";
        UISwitch *signOutSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(165, 5, 100, 30)];
        [cellView addSubview:signOut];
        [cellView addSubview:signOutSwitch];
        [cell.contentView addSubview:cellView];
       
    }
    return cell;
    
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








@end
