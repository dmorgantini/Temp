//
//  Waypoint.m
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "Waypoint.h"
#import "StringExtensions.h"
#import "AudioFile.h"

#define MINIMUM_DELTA_METERS 10.0

@implementation Waypoint

@synthesize coordinate, title, audioText, waypointId, audioFile;

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
    if ((self = [super init]))
    {
        coordinate = inCoord;
        self.waypointId = [NSString stringWithUUID];
    }
    
	return self;
}

-(bool) isTooCloseToo:(Waypoint *)waypoint
{
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:waypoint.coordinate.latitude longitude:waypoint.coordinate.longitude];
    
    CLLocationDistance metersApart = [myLocation distanceFromLocation:otherLocation];

    [myLocation release];
    [otherLocation release];
    
    return metersApart < MINIMUM_DELTA_METERS;
    
}

-(NSURL*) getTempWaypointPath
{
    NSString* fileName = [NSString stringWithFormat:@"%@.caf", self.waypointId];
        
    NSString *tempDir = NSTemporaryDirectory ();
    NSString *fullPath = [tempDir stringByAppendingString: fileName];
    return [NSURL fileURLWithPath:fullPath];
}

-(void)saveAudioFile:(AudioFile *)newAudioFile
{
    self.audioFile = [[AudioFile alloc] initWithUrl:[self getTempWaypointPath]];
    [self.audioFile moveDataFrom:newAudioFile.url];
}

-(void)dealloc
{
    [title release];
    [audioText release];
    [waypointId release];
    [audioFile release];
    [super dealloc];
}

@end
