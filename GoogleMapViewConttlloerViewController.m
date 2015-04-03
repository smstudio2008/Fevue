//
//  GoogleMapViewConttlloerViewController.m
//  Discvr
//
//  Created by Jignesh Mayani on 1/26/15.
//  Copyright (c) 2015 Discvr. All rights reserved.
//

#import "GoogleMapViewConttlloerViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface GoogleMapViewConttlloerViewController ()
{
    GMSMapView *mapView_;
    IBOutlet UIButton *direction;
    IBOutlet UIButton *btnBack;
}
@end

@implementation GoogleMapViewConttlloerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.codinate.latitude
                                                            longitude:self.codinate.longitude
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarker *sydneyMarker = [[GMSMarker alloc] init];
    sydneyMarker.position = CLLocationCoordinate2DMake(self.codinate2.latitude,self.codinate2.longitude);
    sydneyMarker.map = mapView_;
    
    
    
    
    
    
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.codinate.latitude,self.codinate.longitude);
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];

    
    [mapView_ addSubview:btnBack];
      [mapView_ addSubview:direction];
}
-(IBAction)btnBackTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)direction:(id)sender
{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%f,%f",self.codinate1.latitude,self.codinate1.longitude]];
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        NSLog(@"Google Maps app is not installed");
        //left as an exercise for the reader: open the Google Maps mobile website instead!
    } else {
        [[UIApplication sharedApplication] openURL:url];}

}

@end
