//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "TaggableFriendsViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TaggableFriendCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalClass.h"

@interface TaggableFriendsViewController ()


@property (nonatomic, strong) NSArray *taggableFriends;
@property (nonatomic, strong) NSArray *selectableFriends;

@property (nonatomic, weak) IBOutlet UISearchBar *taggableFriendsSearchBar;
@property (nonatomic, weak) IBOutlet UITableView *taggableFriendsTable;


- (IBAction)cancel:(id)sender;


@end


@implementation TaggableFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.taggableFriends = @[];
    self.selectableFriends = self.taggableFriends;
    
    FBRequest *request = [FBRequest requestForGraphPath: @"/me/taggable_friends?fields=name,picture.width(200).height(200)"];
    [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            self.taggableFriendsSearchBar.alpha = 1;
            self.taggableFriendsSearchBar.userInteractionEnabled = YES;
            
            self.taggableFriends = result[@"data"];
            self.selectableFriends = self.taggableFriends;
            
            [self.taggableFriendsTable reloadData];
        }
    }];
    
    [self.taggableFriendsSearchBar setBackgroundImage: [[UIImage alloc] init]];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *matchPredicate = [NSPredicate predicateWithBlock: ^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSDictionary *taggableFriend = (NSDictionary*)evaluatedObject;
        
        return [[taggableFriend[@"name"] lowercaseString] rangeOfString: [searchText lowercaseString]].location != NSNotFound;
    }];
    
    self.selectableFriends = [self.taggableFriends filteredArrayUsingPredicate: matchPredicate];
    
    [self.taggableFriendsTable reloadData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.taggableFriendsSearchBar resignFirstResponder];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectableFriends.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaggableFriendCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TaggableFriendCell" forIndexPath: indexPath];
    NSDictionary *currentFriend = self.selectableFriends[indexPath.row];
    
    cell.friendImage.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.friendImage.layer.borderWidth = 2;
    cell.friendImage.layer.cornerRadius = cell.friendImage.frame.size.width / 2;
    
    NSString *currentFriendImageUrlString = [currentFriend valueForKeyPath: @"picture.data.url"];
    NSURL *currentFriendImageUrl = [NSURL URLWithString: currentFriendImageUrlString];
    [cell.friendImage sd_setImageWithURL: currentFriendImageUrl  placeholderImage: [UIImage imageNamed: @"new-friend"]];
    
    cell.friendName.text = currentFriend[@"name"];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate != nil) {
        [self.delegate friendSelected: self.selectableFriends[indexPath.row]];
       
    }
    
    [self dismissViewControllerAnimated: YES completion: nil];
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end