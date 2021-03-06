//
//  MapController.h
//  YouTour
//
//  Created by dmorgant on 10/31/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WaypointController.h"
#import "CrumbPath.h"
#import "CrumbPathView.h"

@class Waypoint;
@class Tour;

@interface MapController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, ControllerFinishedDelegate>
{
    CLLocationManager *locationManager;
    MKMapView *mapView;
    Tour *tour;
    CrumbPath *crumbs;
    CrumbPathView *crumbView;
    UIBarButtonItem *startRecordButton;
    UIBarButtonItem *stopRecordButton;
    UIBarButtonItem *dropWaypointButton;
    UIBarButtonItem *saveTourButton;
    UIBarButtonItem *nextToolbarButton;
    UIBarButtonItem *previousToolbarButton;
    UIBarButtonItem *viewAllWaypointsButton;
    UIToolbar *toolbar;
    UIBarButtonItem *currentButton;
    UIView *waypointTitleView;
    UITextField *waypointTitleText;
    Waypoint* currentWaypoint;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) Tour *tour;
@property (nonatomic, retain) UIBarButtonItem *startRecordButton;
@property (nonatomic, retain) UIBarButtonItem *stopRecordButton;
@property (nonatomic, retain) UIBarButtonItem *dropWaypointButton;
@property (nonatomic, retain) UIBarButtonItem *saveTourButton;
@property (nonatomic, retain) UIBarButtonItem *nextToobarButton;
@property (nonatomic, retain) UIBarButtonItem *previousToobarButton;
@property (nonatomic, retain) UIBarButtonItem *viewAllWaypointsButton;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIView *waypointTitleView;
@property (nonatomic, retain) IBOutlet UITextField *waypointTitleText;
@property (nonatomic, retain) Waypoint* currentWaypoint;


-(IBAction) endDropWaypoint:(id) sender;

-(void) startRecording:(id) sender;
-(void) stopRecording:(id) sender;
-(void) dropWaypoint:(id)sender;
-(void) saveTour: (id) sender;
-(void) viewAllWaypoints: (id) sender;

-(void) nextToolbar: (id) sender;
-(void) previousToolbar: (id) sender;


@end
