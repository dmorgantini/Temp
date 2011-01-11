//
//  AudioServices.m
//  YouTour
//
//  Created by dmorgant on 11/24/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AudioService.h"
#import "Waypoint.h"
#import "AudioFile.h"

@implementation AudioService
@synthesize audioRecorder, audioPlayer;

-init
{    
    if ((self = [super init]))
    {
    
        NSError* err = nil;
        [[AVAudioSession sharedInstance]
            setCategory: AVAudioSessionCategoryPlayAndRecord
            error: &err];
    
        if (err)
        {
            NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        }
    }
    return self;
}

-(void)startPlaying:(AudioFile *)audioFile delegate:(id<AVAudioPlayerDelegate>)playingDelegate
{
    
    NSError* err = nil;
    
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayAndRecord
     error: &err];
    
    if (err)
    {
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    if ([audioPlayer url] != audioFile.url){
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: audioFile.url
                                           error: nil];
    
        [audioPlayer prepareToPlay];
    }
    
    [audioPlayer setDelegate: playingDelegate];
    
    [audioPlayer play];
}

-(void)stopPlaying:(AudioFile *)audioFile
{
    [audioPlayer stop];
}

-(void)startRecording:(AudioFile *)audioFile
{
    NSError* err = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    audioSession.delegate = self;
    [audioSession setActive: YES error: &err];

    if (err)
    {
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    
    NSDictionary *recordSettings =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
     [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
     [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
     [NSNumber numberWithInt: AVAudioQualityMax],
     AVEncoderAudioQualityKey,
     nil];
    
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL: audioFile.url
                                settings: recordSettings
                                   error: &err];
    
    [recordSettings release];
    
    if (err)
    {
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    audioRecorder.delegate = self;
    [audioRecorder prepareToRecord];
    [audioRecorder record];
    
}

-(void)stopRecording:(AudioFile *)audioFile
{
    [audioRecorder stop];
    self.audioRecorder = nil;
    
    [audioFile logDebug];

}

-(void)dealloc {
    [audioRecorder release];
    [audioPlayer release];
    [super dealloc];
}

@end
