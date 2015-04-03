//
//  holimapViewController.m
//  fevue
//
//  Created by SALEM on 21/02/2015.
//  Copyright (c) 2015 fevue. All rights reserved.
//


#import "holimapViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface holimapViewController ()
{
    GMSMapView *mapView_;
    IBOutlet UIButton *direction;
    IBOutlet UIButton *btnBack;
}
@end

@implementation holimapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.codinate.latitude
                                                            longitude:self.codinate.longitude
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarker *sydneyMarker = [[GMSMarker alloc] init];
    sydneyMarker.position = CLLocationCoordinate2DMake(self.codinate2.latitude,self.codinate2.longitude);
    sydneyMarker.map = mapView_;
    
    GMSMarker *sydneyMarker2 = [[GMSMarker alloc] init];
    sydneyMarker2.position = CLLocationCoordinate2DMake(self.codinate3.latitude,self.codinate3.longitude);
    sydneyMarker2.map = mapView_;
    
    GMSMarker *sydneyMarker3 = [[GMSMarker alloc] init];
    sydneyMarker3.position = CLLocationCoordinate2DMake(self.codinate4.latitude,self.codinate4.longitude);
    sydneyMarker3.map = mapView_;
    
    GMSMarker *sydneyMarker4 = [[GMSMarker alloc] init];
    sydneyMarker4.position = CLLocationCoordinate2DMake(self.codinate5.latitude,self.codinate5.longitude);
    sydneyMarker4.map = mapView_;
    
    
    GMSMarker *sydneyMarker5 = [[GMSMarker alloc] init];
    sydneyMarker5.position = CLLocationCoordinate2DMake(self.codinate6.latitude,self.codinate6.longitude);
    sydneyMarker5.map = mapView_;
    
    GMSMarker *sydneyMarker6 = [[GMSMarker alloc] init];
    sydneyMarker6.position = CLLocationCoordinate2DMake(self.codinate7.latitude,self.codinate7.longitude);
    sydneyMarker6.map = mapView_;
    
    GMSMarker *sydneyMarker7 = [[GMSMarker alloc] init];
    sydneyMarker7.position = CLLocationCoordinate2DMake(self.codinate8.latitude,self.codinate8.longitude);
    sydneyMarker7.map = mapView_;
    
    GMSMarker *sydneyMarker8 = [[GMSMarker alloc] init];
    sydneyMarker8.position = CLLocationCoordinate2DMake(self.codinate9.latitude,self.codinate9.longitude);
    sydneyMarker8.map = mapView_;
    

    
    
    
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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%f,%f",self.direction2.latitude,self.direction2.longitude]];
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        NSLog(@"Google Maps app is not installed");
        //left as an exercise for the reader: open the Google Maps mobile website instead!
    } else {
        [[UIApplication sharedApplication] openURL:url];}
    
}

@end
