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

- (id)init: (NSString*) filePath {
    return [self initWithUrl: [NSURL fileURLWithPath:filePath]];
}

- (id)initWithUrl: (NSURL*) fileUrl {
    if ((self = [super init])) {
        self.url = fileUrl;
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
    NSLog(@"Audio File Size: %lu",size);
}

-(void) deleteFile
{
    if (self.url == nil)
        return;
    
    [[NSFileManager defaultManager] removeItemAtURL:self.url error:nil]; // TODO: error handle here
    self.url = nil;
}

-(void)moveFrom: (NSURL*)fromUrl
{
    
    NSError *err;
    [[NSFileManager defaultManager] moveItemAtURL:fromUrl toURL:self.url error:&err];
    if (err)
    {
        NSLog(@"Move Audio File Failure: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
}

- (void)dealloc {
    [self.url release];
    [super dealloc];
}

+(AudioFile *)createTempAudioFile:(AudioFile *)fromAudioFile
{
    NSString* tempPath = [NSTemporaryDirectory() stringByAppendingString:@"tempAudio.caf"];
    if (fromAudioFile != nil)
    {
        [[NSFileManager defaultManager] 
            copyItemAtURL:fromAudioFile.url 
            toURL:[NSURL fileURLWithPath:tempPath] // Do I need to release this?
            error:nil]; // TODO: Error handle here
    }
    
    return [[[AudioFile alloc] init:tempPath] autorelease];    
}

@end
