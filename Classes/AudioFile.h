//
//  AudioFile.h
//  YouTour
//
//  Created by dmorgant on 12/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AudioFile : NSObject {
    NSURL* url;
}

@property (retain, nonatomic) NSURL* url;


-(id) initWithUrl: (NSURL*) fileUrl;
-(void) logDebug;
-(void) deleteFile;
-(void) moveFrom: (NSURL*) fromUrl;

+(AudioFile*)createTempAudioFile:(AudioFile*)fromAudioFile;


@end
