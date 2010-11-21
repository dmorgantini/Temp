//
//  Waypoint.m
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "Waypoint.h"

#define MINIMUM_DELTA_METERS 10.0

@implementation Waypoint

@synthesize coordinate, title, audioText;

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}

-(bool) isTooCloseToo:(Waypoint *)waypoint
{
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:waypoint.coordinate.latitude longitude:waypoint.coordinate.longitude];
    
    CLLocationDistance metersApart = [myLocation distanceFromLocation:otherLocation];
    
    return metersApart < MINIMUM_DELTA_METERS;
    
    [myLocation release];
    
}
@end
