//
//  instaViewController.m
//  fevue
//
//  Created by SALEM on 24/11/2014.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import "instaViewController.h"
#import "SBInstagramController.h"
#import "SBInstagramModel.h"
#import "VBFPopFlatButton.h"

@interface instaViewController()

@property (nonatomic, strong) NSMutableArray *mediaArray;
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property (nonatomic, strong) SBInstagramController *instagramController;
@property (nonatomic, assign) BOOL downloading;
@property (nonatomic, assign) BOOL hideFooter;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableArray *videoPlayerArr;
@property (nonatomic, strong) NSMutableArray *videoPlayerImagesArr;

@property (nonatomic, strong) NSArray *multipleLastEntities;

@end

@implementation instaViewController

-(NSString *)version{
    return @"2.0.1";
}

- (id) initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if ((self = [super initWithCollectionViewLayout:layout])) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityIndicator startAnimating];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.downloading = YES;
    
    self.mediaArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.collectionView registerClass:[instacellController class] forCellWithReuseIdentifier:@"instacellController"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.multipleLastEntities = [NSArray array];
    
    self.instagramController = [SBInstagramController instagramControllerWithMainViewController:self];
    self.instagramController.isSearchByTag = self.isSearchByTag;
    self.instagramController.searchTag = self.searchTag;
    [self downloadNext];
    
    self.collectionView.alwaysBounceVertical = YES;
    refreshControl_ = [[instaRefreshController alloc] initInScrollView:self.collectionView];
    [refreshControl_ addTarget:self action:@selector(refreshCollection2:) forControlEvents:UIControlEventValueChanged];
    
    loaded_ = YES;
    
    self.videoPlayerArr = [NSMutableArray array];
    self.videoPlayerImagesArr = [NSMutableArray array];
    [self showSwitch];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];

    
    
    _flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(17, 22, 22, 22)
                                                     buttonType:buttonCloseType
                                                    buttonStyle:buttonRoundedStyle
                                          animateToInitialState:YES];
    _flatRoundedButton.roundBackgroundColor = [UIColor blackColor];
    _flatRoundedButton.lineThickness = 1.5;
    _flatRoundedButton.lineRadius = 3;
    _flatRoundedButton.tintColor = [UIColor whiteColor];
    [_flatRoundedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: _flatRoundedButton];
    

}





-(void) segmentChanged:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    if (self.showOnePicturePerRow != segmentedControl.selectedSegmentIndex) {
        self.showOnePicturePerRow = segmentedControl.selectedSegmentIndex;
    }
}

- (void) refreshCollection2{
    [self refreshCollection2:nil];
}

- (void) refreshCollection2:(id) sender{
    [self.mediaArray removeAllObjects];
    [self downloadNext];
    if (self.activityIndicator.isAnimating)
        [self.activityIndicator stopAnimating];
}

- (void) downloadNext{
    __weak typeof(self) weakSelf = self;
    self.downloading = YES;
    if (!self.activityIndicator.isAnimating)
        [self.activityIndicator startAnimating];
    if ([self.mediaArray count] == 0) {
        
        //multiple users id
        if ([SBInstagramModel model].instagramMultipleUsersId) {
            [self.instagramController mediaMultipleUserWithArr:[SBInstagramModel model].instagramMultipleUsersId complete:^(NSArray *mediaArray,NSArray *lastMedias, NSError *error) {
                if ([refreshControl_ isRefreshing]) {
                    [refreshControl_ endRefreshing];
                }
                if (mediaArray.count == 0 && error) {
                    SB_showAlert(@"Instagram", @"No results found", @"OK");
                    [weakSelf.activityIndicator stopAnimating];
                }else{
                    [weakSelf.mediaArray addObjectsFromArray:mediaArray];
                    [weakSelf.collectionView reloadData];
                    weakSelf.multipleLastEntities = lastMedias;
                }
                weakSelf.downloading = NO;
            }];
        }
        //only one user configured
        else{
            NSString *uId = [SBInstagramModel model].instagramUserId ?: INSTAGRAM_USER_ID;
            if (SBInstagramModel.isSearchByTag && [SBInstagramModel searchTag].length > 0) {
                uId = [SBInstagramModel searchTag];
            }
            
            [self.instagramController mediaUserWithUserId:uId andBlock:^(NSArray *mediaArray, NSError *error) {
                if ([refreshControl_ isRefreshing]) {
                    [refreshControl_ endRefreshing];
                }
                if (error || mediaArray.count == 0) {
                    SB_showAlert(@"Instagram", @"No results found", @"OK");
                    [weakSelf.activityIndicator stopAnimating];
                }else{
                    [weakSelf.mediaArray addObjectsFromArray:mediaArray];
                    [weakSelf.collectionView reloadData];
                }
                weakSelf.downloading = NO;
                
            }];
        }
    }
    //download nexts
    else{
        
        //multiple users id
        if ([SBInstagramModel model].instagramMultipleUsersId) {
            
            [self.instagramController mediaMultiplePagingWithArr:self.multipleLastEntities complete:^(NSArray *mediaArray, NSArray *lastMedia, NSError *error) {
                
                weakSelf.multipleLastEntities = lastMedia;
                
                NSUInteger a = [self.mediaArray count];
                [weakSelf.mediaArray addObjectsFromArray:mediaArray];
                
                NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
                [mediaArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSUInteger b = a+idx;
                    NSIndexPath *path = [NSIndexPath indexPathForItem:b inSection:0];
                    [arr addObject:path];
                }];
                
                [weakSelf.collectionView performBatchUpdates:^{
                    [weakSelf.collectionView insertItemsAtIndexPaths:arr];
                } completion:nil];
                
                weakSelf.downloading = NO;
                
                if (mediaArray.count == 0) {
                    [weakSelf.activityIndicator stopAnimating];
                    weakSelf.activityIndicator.hidden = YES;
                    weakSelf.hideFooter = YES;
                    [weakSelf.collectionView reloadData];
                }
            }];
            
        }else{
            
            [self.instagramController mediaUserWithPagingEntity:[self.mediaArray objectAtIndex:(self.mediaArray.count-1)] andBlock:^(NSArray *mediaArray, NSError *error) {
                
                NSUInteger a = [self.mediaArray count];
                [weakSelf.mediaArray addObjectsFromArray:mediaArray];
                
                NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
                [mediaArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSUInteger b = a+idx;
                    NSIndexPath *path = [NSIndexPath indexPathForItem:b inSection:0];
                    [arr addObject:path];
                }];
                
                [weakSelf.collectionView performBatchUpdates:^{
                    [weakSelf.collectionView insertItemsAtIndexPaths:arr];
                } completion:nil];
                
                weakSelf.downloading = NO;
                
                if (mediaArray.count == 0) {
                    [weakSelf.activityIndicator stopAnimating];
                    weakSelf.activityIndicator.hidden = YES;
                    weakSelf.hideFooter = YES;
                    [weakSelf.collectionView reloadData];
                }
                
            }];
        }
    }
    
}


- (void) setShowOnePicturePerRow:(BOOL)showOnePicturePerRow{
    BOOL reload = NO;
    if (_showOnePicturePerRow != showOnePicturePerRow) {
        reload = YES;
    }
    _showOnePicturePerRow = showOnePicturePerRow;
    if (reload && loaded_) {
        [self.collectionView reloadData];
    }
    
}

- (void) setShowSwitchModeView:(BOOL)showSwitchModeView{
    _showSwitchModeView = showSwitchModeView;
    if (loaded_) {
        [self showSwitch];
    }
    
}

- (void) showSwitch{
    if (self.showSwitchModeView) {
        segmentedControl_ = [[UISegmentedControl alloc] initWithItems:@[[UIImage imageNamed:@"sb-grid-selected.png"],[UIImage imageNamed:@"sb-table-selected.png"]]];
        [self.view addSubview:segmentedControl_];
        
        segmentedControl_.segmentedControlStyle = UISegmentedControlStylePlain;
        CGRect frame = segmentedControl_.frame;
        frame.origin.y = 5;
        frame.size.width  = 200;
        frame.origin.x = self.view.center.x - 100;
        segmentedControl_.frame = frame;
        segmentedControl_.selectedSegmentIndex = _showOnePicturePerRow;
        [segmentedControl_ addTarget:self
                              action:@selector(segmentChanged:)
                    forControlEvents:UIControlEventValueChanged];
        
        frame = self.collectionView.frame;
        frame.origin.y = CGRectGetMaxY(segmentedControl_.frame) + 5;
        frame.size.height = CGRectGetHeight([[UIScreen mainScreen] applicationFrame]) - CGRectGetMinY(frame);
        self.collectionView.frame = frame;
        
    }else{
        if (segmentedControl_) {
            [segmentedControl_ removeFromSuperview];
            segmentedControl_ = nil;
        }
        
        CGRect frame = self.collectionView.frame;
        frame.origin.y = 0;
        frame.size.height = CGRectGetHeight([[UIScreen mainScreen] applicationFrame]);
        self.collectionView.frame = frame;
    }
}

//- (void) playVideo{
//
//    if (self.videoPlayerArr.count == 0) {
//        return;
//    }
//
//    [self.videoPlayerArr enumerateObjectsUsingBlock:^(SBInstagramCell *cell, NSUInteger idx, BOOL *stop) {
//        if (cell.avPlayer) {
//            [cell.avPlayer pause];
//        }
//    }];
//
//    [self.videoPlayerArr enumerateObjectsUsingBlock:^(SBInstagramCell *cell, NSUInteger idx, BOOL *stop) {
//        if (cell.entity.mediaEntity.type == SBInstagramMediaTypeVideo) {
//            NSString *url = ((SBInstagramVideoEntity *) cell.entity.mediaEntity.videos[@"low_resolution"]).url;
//            if ([SBInstagramModel model].playStandardResolution) {
//                url = ((SBInstagramVideoEntity *) cell.entity.mediaEntity.videos[@"standard_resolution"]).url;
//            }
//
//            [cell playVideo:url];
//
//        }
//        *stop = YES;
//
//    }];
//
//}

- (void) pauseAllVideos:(AVPlayer *)avPlayer{
    [self.videoPlayerArr enumerateObjectsUsingBlock:^(AVPlayer *obj, NSUInteger idx, BOOL *stop) {
        if (avPlayer != obj) {
            [obj pause];
            UIImageView *img = self.videoPlayerImagesArr[idx];
            img.image = [UIImage imageNamed:[SBInstagramModel model].videoPlayImageName];
        }else{
            UIImageView *img = self.videoPlayerImagesArr[idx];
            img.image = [UIImage imageNamed:[SBInstagramModel model].videoPauseImageName];
        }
    }];
    [avPlayer play];
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.mediaArray count];
}



///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    instacellController *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"instacellController" forIndexPath:indexPath];
    
    if ([self.mediaArray count]>0) {
        SBInstagramMediaPagingEntity *entity = [self.mediaArray objectAtIndex:indexPath.row];
        cell.indexPath = indexPath;
        cell.showOnePicturePerRow = self.showOnePicturePerRow;
        [cell setVideoControlBlock:^(AVPlayer *avPlayer, BOOL tap, UIImageView *videoPlayImage) {
            if (!tap) {
                [self.videoPlayerArr addObject:avPlayer];
                [self.videoPlayerImagesArr addObject:videoPlayImage];
                //                [self playVideo];
            }else{
                [self pauseAllVideos:avPlayer];
            }
            
        }];
        [cell setEntity:entity andIndexPath:indexPath];
        //        [self.videoPlayerArr addObject:cell];
        //        [self playVideo];
        
        
    }
    
    if (indexPath.row == [self.mediaArray count]-1 && !self.downloading) {
        [self downloadNext];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell1 forItemAtIndexPath:(NSIndexPath *)indexPath

{
    if ([collectionView.indexPathsForVisibleItems indexOfObject:indexPath] == NSNotFound)
    {
        
        instacellController *cell = (instacellController *)cell1;
        [cell.avPlayer pause];
        [cell removeNoti];
        [self.videoPlayerArr removeObject:cell.avPlayer];
        [self.videoPlayerImagesArr removeObject:cell.videoPlayImage];
        
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.hideFooter) {
        return CGSizeZero;
    }
    return CGSizeMake(CGRectGetWidth(self.view.frame),40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind != UICollectionElementKindSectionFooter || self.hideFooter){
        return nil;
    }
    
    UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    CGPoint center = self.activityIndicator.center;
    center.x = foot.center.x;
    center.y = 20;
    self.activityIndicator.center = center;
    
    [foot addSubview:self.activityIndicator];
    
    return foot;
}


///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.showOnePicturePerRow) {
        if (SB_IS_IPAD) {
            return CGSizeMake(600, 680);
        }
        return CGSizeMake(320, 320);
    }else{
        if (SB_IS_IPAD) {
            return CGSizeMake(200, 200);
        }
        return CGSizeMake(159, 159);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.showOnePicturePerRow) {
        return 0;
    }
    return 1* (SB_IS_IPAD?2:1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.showOnePicturePerRow) {
        return 0;
    }
    return 1 * (SB_IS_IPAD?2:1);
}

// MARK Containment methods
- (UIViewController*)currentViewController {
    UIViewController *currentViewController = nil;
    
    if (self.childViewControllers.count > 0) {
        currentViewController = self.childViewControllers[0];
    }
    
    return currentViewController;
}


- (void)showContentController: (UIViewController*)content {
    [self animateFromViewController: [self currentViewController]
                   toViewController: content];
}


- (void)dismissContentController {
    [self animateFromViewController: [self currentViewController]
                   toViewController: nil];
}


- (void)animateFromViewController: (UIViewController *)fromViewController toViewController: (UIViewController *)toViewController {
    double offset = self.view.frame.size.height / 3 - 10;
    
    if (toViewController != nil) {
        toViewController.view.frame = CGRectMake(0,
                                                 self.view.frame.size.height,
                                                 self.view.frame.size.width,
                                                 self.view.frame.size.height - offset);
        
        [self addChildViewController: toViewController];
        [self.view addSubview: toViewController.view];
    }
    
    // MARK
    ///////////////////
    [fromViewController willMoveToParentViewController: nil];
    [fromViewController removeFromParentViewController];
    ///////////////////
    
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^ {
                         fromViewController.view.frame = CGRectMake(0,
                                                                    self.view.frame.size.height,
                                                                    self.view.frame.size.width,
                                                                    self.view.frame.size.height - offset);
                         
                         if (toViewController != nil) {
                             toViewController.view.frame = CGRectMake(0,
                                                                      offset,
                                                                      self.view.frame.size.width,
                                                                      self.view.frame.size.height - offset);
                         }
                     }
                     completion: ^(BOOL finished) {
                         //[fromViewController willMoveToParentViewController: nil];
                         [fromViewController.view removeFromSuperview];
                         //[fromViewController removeFromParentViewController];
                         
                         if (toViewController != nil) {
                             [toViewController didMoveToParentViewController: self];
                         }
                     }];
}

- (void)buttonPressed:(id)sender {

 [self dismissViewControllerAnimated:YES completion:nil];

}
@end

