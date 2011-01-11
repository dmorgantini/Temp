//
//  AudioFile.h
//  YouTour
//
//  Created by dmorgant on 12/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AudioFile : NSObject {
@private

}

@property (retain, nonatomic) NSURL* url;

-(void) logDebug;
-(void) deleteFile;


+(AudioFile*)createTempAudioFile:(AudioFile*)fromAudioFile;


@end
