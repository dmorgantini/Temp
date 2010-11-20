//
//  WaypointList.m
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "WaypointList.h"
#import "Waypoint.h"


@implementation WaypointList

@synthesize waypoints;

-init
{
    waypoints = [[NSMutableArray alloc] init];
    return self;
}

-(bool) testWaypoint:(Waypoint *)waypoint
{
    
    Waypoint *item;
    for(item in waypoints) // This is likely not going to be terribly efficient.  Will need to optimize
    {
        if ([item isTooCloseToo: waypoint])
            return NO;
        
    }
    
    return YES;
}
-(void) add:(Waypoint *)waypoint
{
    [waypoints addObject:waypoint];
}

-(Waypoint*) getWaypointAtIndex: (int) index
{
    return (Waypoint*)[waypoints objectAtIndex:index];
    
}

-(int) countWaypoints
{
    return [waypoints count];
}


- (void)dealloc {
    [waypoints release];
    [super dealloc];
}


@end
