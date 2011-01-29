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
-(void) clearData;
-(void) moveDataFrom: (NSURL*) fromUrl;
-(void) copyDataFrom: (NSURL*) fromUrl;
-(bool) hasData;

+(AudioFile*)createTempAudioFile:(AudioFile*)fromAudioFile;


@end
