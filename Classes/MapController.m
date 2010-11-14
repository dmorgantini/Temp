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
@end

@implementation MapController

@synthesize locationManager, mapView, tour, startRecordButton, stopRecordButton, dropWaypointButton, toolbar,
saveTourButton, nextToobarButton, previousToobarButton, currentButton;

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
            [toolbar setItems:[NSArray arrayWithObjects:recordActionButton, dropWaypointButton, 
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
    Waypoint *newWaypoint = [[Waypoint alloc] initWithCoordinate:self.locationManager.location.coordinate];
    
    bool shouldAddWaypoint = [self.tour addWaypoint: newWaypoint];
    
    if (shouldAddWaypoint)
        [self.mapView addAnnotation: newWaypoint];
    
    [newWaypoint release];
    
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


-(BOOL) isCoordinate:(CLLocationCoordinate2D) first equalTo: (CLLocationCoordinate2D) second
{
    return ((first.latitude == second.latitude) && (first.longitude == second.longitude));
}

-(void) initToolbarButtons
{
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
    
    
    self.nextToobarButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" 
                                                             style:UIBarButtonItemStyleBordered 
                                                            target:self 
                                                            action:@selector(nextToolbar:)];
    
    self.previousToobarButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev" 
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [crumbs release];
    [crumbView release];
    
    // TODO: release a bunch of stuff here!!!
    
    [super dealloc];
}


@end
