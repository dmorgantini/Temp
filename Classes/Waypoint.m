//
//  Waypoint.m
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "Waypoint.h"
#import "StringExtensions.h"

#define MINIMUM_DELTA_METERS 10.0

@implementation Waypoint

@synthesize coordinate, title, audioText, waypointId, audioFile;

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
    if (self = [super init])
    {
        coordinate = inCoord;
        waypointId = [NSString stringWithUUID];
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

-(void)saveAudioFile:(AudioFile *)audioFile
{
    
}

-(bool)hasAudio
{
    return NO;
}

//-(void) saveAudioData:(NSData *)data withExtension:(NSString*) ext
//{
//    
//    NSString* fileName = [self.waypointId stringByAppendingString:[@"." stringByAppendingString: ext]];
//    
//    NSString *tempDir = NSTemporaryDirectory ();
//    NSString *soundFilePath = [tempDir stringByAppendingString: fileName];
//    
//    NSError* err = nil;
//    
//    if (![data writeToFile:soundFilePath options:NSDataWritingAtomic error:&err])
//    {
//        NSLog(@"write to file: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
//        return;   
//    }
//}

@end
