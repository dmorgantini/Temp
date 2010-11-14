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

-(bool) addWaypoint:(id)newWaypoint
{
    return [waypointList add: newWaypoint];
}

-(bool) addRouteLocation:(CLLocation *)newLocation
{
    // do the analysation of the location right here... accuracy etc
    if (newLocation.horizontalAccuracy <= 50)
        return NO;
    
    NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceNow];
    
    if (timeInterval > 60) // more than 60secs since last update
        return NO;
    
    
    [self.route addLocation: newLocation];
    
    return YES;
    
}

-(NSMutableArray*) getAllWaypoints
{
    return waypointList.waypoints;
}

-(void) dealloc {
	[details release];
    [route release];
	[super dealloc];
}

@end
