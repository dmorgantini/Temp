//
//  WaypointList.m
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "WaypointList.h"
#import "Waypoint.h"

@interface WaypointList()
@property (nonatomic, retain) NSMutableArray* waypoints;

@end

@implementation WaypointList

@synthesize waypoints;

-init
{
    waypoints = [[NSMutableArray alloc] init];
    return self;
}

-(bool) add:(Waypoint *)waypoint
{
    
    Waypoint *item;
    for(item in waypoints) // This is likely not going to be terribly efficient.  Will need to optimize
    {
        if ([item isTooCloseToo: waypoint])
            return NO;
        
    }
    
    [waypoints addObject:waypoint];
    return YES;
}


- (void)dealloc {
    waypoints = nil;
    [super dealloc];
}


@end
