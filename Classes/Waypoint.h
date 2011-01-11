//
//  Waypoint.h
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class AudioFile;

@interface Waypoint : NSObject <MKAnnotation>{
    NSString* title;
    NSString* audioText;
    NSString* waypointId;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* audioText;
@property (nonatomic, retain) NSString* waypointId;
@property (nonatomic, retain) AudioFile* audioFile;

-(bool) isTooCloseToo: (Waypoint*) waypoint;
-(bool) hasAudio;
-(void) saveAudioFile: (AudioFile*) audioFile;


@end
