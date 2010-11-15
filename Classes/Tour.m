//
//  Tour.m
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "Tour.h"
#import "TourDetails.h"
#import "TourRoute.h"
#import "WaypointList.h"

@implementation Tour
@synthesize details, isNew, route, waypointList;

-(Tour*) initNew {
	self = [super init];
	
    if (self) {
		self.details = [[TourDetails alloc] init];
		self.isNew = YES;
        self.route = [[TourRoute alloc] init];
        self.waypointList = [[WaypointList alloc] init];
	}
	
	return self;
}

-(void) addWaypoint:(Waypoint*) newWaypoint
{
    return [waypointList add: newWaypoint];
}

-(bool) testWaypoint:(Waypoint *)newWaypoint
{
    return [waypointList testWaypoint: newWaypoint];
}

-(bool) addRouteLocation:(CLLocation *)newLocation
{
#if !(TARGET_IPHONE_SIMULATOR)
    if (newLocation.horizontalAccuracy >= 20)
    {
        NSLog(@"Rejecting horizontal accuracy of: %f", newLocation.horizontalAccuracy);
        return NO;
    }
    
    NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceNow];
    
    if (timeInterval > 60) // more than 60secs since last update
    {
        NSLog(@"Rejecting location because it was updated %f seconds ago", timeInterval);
        return NO;
    }
#endif
    
    [self.route addLocation: newLocation];
    
    return YES;
    
}

-(NSMutableArray*) getAllWaypoints
{
    return waypointList.waypoints;
}

-(Waypoint *) getWaypointAtIndex: (int) index
{
    return [waypointList getWaypointAtIndex: index];
    
}

-(void) dealloc {
	[details release];
    [route release];
	[super dealloc];
}

@end
