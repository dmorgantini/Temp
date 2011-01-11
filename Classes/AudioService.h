//
//  AudioServices.h
//  YouTour
//
//  Created by dmorgant on 11/24/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class AudioFile;

@interface AudioService : NSObject <AVAudioSessionDelegate, AVAudioRecorderDelegate> {
    AVAudioRecorder* audioRecorder;
    AVAudioPlayer* audioPlayer;
}

@property (retain, nonatomic) AVAudioRecorder* audioRecorder;
@property (retain, nonatomic) AVAudioPlayer* audioPlayer;

- (void) startRecording: (AudioFile*) audioFile;
- (void) stopRecording: (AudioFile*) audioFile;
- (void) startPlaying: (AudioFile*) audioFile delegate: (id<AVAudioPlayerDelegate>)playingDelegate;
- (void) stopPlaying: (AudioFile*) audioFile;

@end
