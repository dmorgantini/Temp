//
//  MapController.h
//  YouTour
//
//  Created by dmorgant on 10/31/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Tour;

#import "CrumbPath.h"
#import "CrumbPathView.h"

@interface MapController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    MKMapView *mapView;
    Tour *tour;
    CrumbPath *crumbs;
    CrumbPathView *crumbView;
    UIBarButtonItem *startRecordButton;
    UIBarButtonItem *stopRecordButton;
    UIToolbar *toolbar;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) Tour *tour;
@property (nonatomic, retain) UIBarButtonItem *startRecordButton;
@property (nonatomic, retain) UIBarButtonItem *stopRecordButton;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;


-(void) startRecording:(id) sender;
-(void) stopRecording:(id) sender;
-(void) initToolbar: recordActionButton;

@end
