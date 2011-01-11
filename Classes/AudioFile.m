//
//  AudioFile.m
//  YouTour
//
//  Created by dmorgant on 12/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "AudioFile.h"


@implementation AudioFile

@synthesize url;

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}


-(void)logDebug
{
    NSLog(@"Audio File Path: %@", [self.url path]);
    
    NSDictionary* attr = [[NSFileManager defaultManager] 
                          attributesOfItemAtPath:[self.url path] 
                          error:nil];
    UInt32 size = [attr fileSize];
    NSLog(@"Audio File Size: %d",size);
}

-(void) deleteFile
{
    
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

+(AudioFile *)createTempAudioFile:(AudioFile *)fromAudioFile
{
    if (fromAudioFile == nil)
    {
        
        return nil;
    }
    else
    {
        
    }
    
}

@end
