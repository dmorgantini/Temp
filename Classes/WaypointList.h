//
//  WaypointList.h
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Waypoint;

@interface WaypointList : NSObject {
    NSMutableArray* waypoints;
}


@property (nonatomic, retain) NSMutableArray* waypoints;
-(void) add: (Waypoint*) waypoint;
-(bool) testWaypoint: (Waypoint*) waypoint;


@end
