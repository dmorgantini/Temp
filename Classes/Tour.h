//
//  Tour.h
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class TourDetails;
@class TourRoute;
@class WaypointList;
@class Waypoint;

@interface Tour : NSObject {
	TourDetails* details;
	bool isNew;
    TourRoute* route;
    WaypointList* waypointList;
}

-(Tour*) initNew;
-(bool) addRouteLocation: (CLLocation *) newLocation;
-(bool) addWaypoint: (Waypoint *) newWaypoint;
-(NSMutableArray*) getAllWaypoints;

@property (nonatomic, retain) TourDetails* details;
@property (nonatomic) bool isNew;
@property (nonatomic, retain) TourRoute* route;
@property (nonatomic, retain) WaypointList* waypointList;

@end
