//
//  MapController.m
//  YouTour
//
//  Created by dmorgant on 10/31/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "MapController.h"
#import "Tour.h"
#import "Waypoint.h"
#import "Alert.h"
#import "WaypointController.h"
#import "WaypointDetailsController.h"
#import "ControllerFinishedDelegate.h"

typedef enum {
    recordingToolbar,
    editorControlsToolbar,
    playbackToolbar

} Toolbars;

@interface MapController()
@property (nonatomic, retain) UIBarButtonItem *currentButton;
-(BOOL) isCoordinate:(CLLocationCoordinate2D) first equalTo: (CLLocationCoordinate2D) second;
-(void) initToolbarButtons;
-(void) initToolbar: recordActionButton;
-(void) initToolbar: recordActionButton andShow: (Toolbars) toolbar;
-(void) updateAnnotations;
-(void) addWaypoint:(Waypoint*)waypoint;
@end

@implementation MapController

@synthesize locationManager, mapView, tour, startRecordButton, stopRecordButton, dropWaypointButton, toolbar,
saveTourButton, nextToobarButton, previousToobarButton, currentButton, waypointTitleView, waypointTitleText, currentWaypoint, viewAllWaypointsButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self; // Tells the location manager to send updates to this object
    
    // TODO: Should this be configurable?
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // init toolbar
    [self initToolbarButtons];
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if ((newLocation == nil) || [self isCoordinate:newLocation.coordinate equalTo:oldLocation.coordinate] )
    {
        return;
    }
    
    bool addedToMap = [self.tour addRouteLocation: newLocation];
    
    if (!addedToMap)
        return;
    
    if (!crumbs)
    {
        // This is the first time we're getting a location update, so create
        // the CrumbPath and add it to the map.
        
        // Do accuracy checking + timestamp
        
        crumbs = [[CrumbPath alloc] initWithCenterCoordinate:newLocation.coordinate];
        [mapView addOverlay:crumbs];
        
        // On the first location update only, zoom map to user location
        MKCoordinateRegion region = 
        MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000);
        [mapView setRegion:region animated:YES];
        
    }
    else
    {
        // This is a subsequent location update.
        // If the crumbs MKOverlay model object determines that the current location has moved
        // far enough from the previous location, use the returned updateRect to redraw just
        // the changed area.
        //
        // note: iPhone 3G will locate you using the triangulation of the cell towers.
        // so you may experience spikes in location data (in small time intervals)
        // due to 3G tower triangulation.
        // 
        MKMapRect updateRect = [crumbs addCoordinate:newLocation.coordinate];
        
        if (!MKMapRectIsNull(updateRect))
        {
            // There is a non null update rect.chr 
            // Compute the currently visible map zoom scale
            MKZoomScale currentZoomScale = mapView.bounds.size.width / mapView.visibleMapRect.size.width;
            // Find out the line width at this zoom scale and outset the updateRect by that amount
            CGFloat lineWidth = MKRoadWidthAtZoomScale(currentZoomScale);
            updateRect = MKMapRectInset(updateRect, -lineWidth, -lineWidth);
            // Ask the overlay view to update just the changed area.
            [crumbView setNeedsDisplayInMapRect:updateRect];
        }
        
        // At one point I'm going to have to move the zoomed region
    }
    
}

-(void) updateAnnotations
{    
    [self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist
    
    [self.mapView addAnnotations:[tour getAllWaypoints]];
}

-(void) addWaypoint:(Waypoint *)waypoint
{
    [self.mapView addAnnotation:waypoint];
}

-(void) initToolbar: (id) recordActionButton
{
    [self initToolbar:recordActionButton andShow:recordingToolbar];
    
}

-(void) initToolbar: (id) recordActionButton andShow:(Toolbars)thisToolbar
{
    self.currentButton = recordActionButton;
    
    UIBarButtonItem *flexibleSpace =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    switch (thisToolbar)
    {
        case recordingToolbar:
            [toolbar setItems:[NSArray arrayWithObjects:recordActionButton, dropWaypointButton, viewAllWaypointsButton,
                               flexibleSpace, nextToobarButton, nil]];
            break;
        case editorControlsToolbar:
            [toolbar setItems:[NSArray arrayWithObjects:previousToobarButton, saveTourButton, nil]];
            break;
        case playbackToolbar:
            [toolbar setItems:[NSArray arrayWithObjects:nil]];
            break;
    }
    
    [flexibleSpace release];
}

-(void) startRecording :(id) sender
{
    [self initToolbar:stopRecordButton];
    [locationManager startUpdatingLocation];
    self.dropWaypointButton.enabled = YES;
}

-(void) stopRecording :(id) sender
{
    [self initToolbar:startRecordButton];
    [locationManager stopUpdatingLocation];
    self.dropWaypointButton.enabled = NO;
}

-(void) dropWaypoint:(id)sender
{
    
    // memory leak here???
    self.currentWaypoint = [[Waypoint alloc] initWithCoordinate:self.locationManager.location.coordinate];
    
    bool canBeAdded = [self.tour testWaypoint: self.currentWaypoint];
    
    if (canBeAdded)
    {
        [mapView addSubview:waypointTitleView];
        waypointTitleText.text = @"";
        [waypointTitleText becomeFirstResponder];
        [waypointTitleText becomeFirstResponder];
    }
    else
        [Alert showAlert: @"Waypoint too close" withMessage: @"Unable to add waypoint, ensure that you have moved some distance (10m) from the previous waypoint"];
}

-(void) viewAllWaypoints:(id)sender
{
    WaypointController *controller = [[WaypointController alloc] initWithNibName:@"WaypointController" bundle:nil];
    controller.delegate = self;
    controller.tour = self.tour;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

-(void) endDropWaypoint : (id) sender
{
    // do a validation here.
    [waypointTitleView removeFromSuperview];
    [self.currentWaypoint setTitle: waypointTitleText.text];
    [self.tour addWaypoint:self.currentWaypoint];
    [self addWaypoint:self.currentWaypoint];
}

-(void) saveTour: (id) sender
{
    NSLog(@"Save tour!!");
}

-(void) nextToolbar:(id)sender
{
    [self initToolbar:currentButton andShow:editorControlsToolbar];
}

-(void) previousToolbar:(id)sender 
{
    [self initToolbar:currentButton andShow:recordingToolbar];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if (!crumbView)
    {
        crumbView = [[CrumbPathView alloc] initWithOverlay:overlay];
    }
    return crumbView;
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
 
    if ([annotation isKindOfClass:[Waypoint class]])
    {
        // try to dequeue an existing pin view first
        static NSString* waypointAnnotationIdentifier = @"waypointAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:waypointAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:waypointAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];         
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    else // currently only have one type of annotation (maybe add more? start. stop. etc
        return nil;
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    WaypointDetailsController *controller = [[WaypointDetailsController alloc] initWithNibName:@"WaypointDetailsController" bundle:nil];
    controller.delegate = self;
    controller.waypoint = (Waypoint*)view.annotation;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
    
    
    
}

-(void) controllerDidFinish: (id) sender
{
    [self updateAnnotations];
    [self dismissModalViewControllerAnimated:YES];
}


-(void) showDetails:(id)sender
{
    
    
    NSLog(@"Waypoint details!!!");
}


-(BOOL) isCoordinate:(CLLocationCoordinate2D) first equalTo: (CLLocationCoordinate2D) second
{
    return ((first.latitude == second.latitude) && (first.longitude == second.longitude));
}

-(void) initToolbarButtons
{
    // lazy load?
    
    self.dropWaypointButton = [[UIBarButtonItem alloc]   initWithTitle:@"Waypoint"
                                                                 style:UIBarButtonItemStyleBordered 
                                                                target:self 
                                                                action:@selector(dropWaypoint:)];
    
    self.dropWaypointButton.enabled = NO;
    
    self.startRecordButton = [[UIBarButtonItem alloc] initWithTitle:@"Record" 
                                                              style:UIBarButtonItemStyleBordered 
                                                             target:self 
                                                             action:@selector(startRecording:)];
    
    self.stopRecordButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" 
                                                             style:UIBarButtonItemStyleBordered 
                                                            target:self 
                                                            action:@selector(stopRecording:)];
    self.stopRecordButton.possibleTitles = [NSSet setWithObjects:@"Record", @"Stop", nil]; // make it the same size as record
    
    self.saveTourButton = [[UIBarButtonItem alloc] initWithTitle:@"Save Tour" 
                                                           style:UIBarButtonItemStyleBordered 
                                                          target:self 
                                                          action:@selector(saveTour:)];
    
    self.viewAllWaypointsButton = [[UIBarButtonItem alloc] initWithTitle:@"View Waypoints" 
                                                           style:UIBarButtonItemStyleBordered 
                                                           target:self 
                                                                  action:@selector(viewAllWaypoints:)];
    
    
    self.nextToobarButton = [[UIBarButtonItem alloc] initWithTitle:@">" 
                                                             style:UIBarButtonItemStyleBordered 
                                                            target:self 
                                                            action:@selector(nextToolbar:)];
    
    self.previousToobarButton = [[UIBarButtonItem alloc] initWithTitle:@"<" 
                                                                 style:UIBarButtonItemStyleBordered 
                                                                target:self 
                                                                action:@selector(previousToolbar:)];
    
    [self initToolbar:startRecordButton];
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.waypointTitleView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [crumbs release];
    [crumbView release];
    [currentWaypoint release];
    [waypointTitleView release];
    
    // TODO: release a bunch of stuff here!!!
    
    [super dealloc];
}


@end
