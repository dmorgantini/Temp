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

-(void) clearData
{
    NSError *err = nil;
    
    [[NSFileManager defaultManager] removeItemAtURL:self.url error:&err];
    
    if (err)
    {
        NSLog(@"Clear Audio File Failure: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
}

-(bool) hasData
{
    return self.url != nil && [[NSFileManager defaultManager] fileExistsAtPath:[self.url path]];
}


-(void)moveDataFrom: (NSURL*)fromUrl
{
    if ([self hasData])
        [self clearData];
    
    NSError *err = nil;
    [[NSFileManager defaultManager] moveItemAtURL:fromUrl toURL:self.url error:&err];
    if (err)
    {
        NSLog(@"Move Audio File Failure: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
}

-(void)copyDataFrom:(NSURL*)fromUrl
{
    if ([self hasData])
        [self clearData];
    
    NSError *err = nil;
    [[NSFileManager defaultManager] copyItemAtURL:fromUrl toURL:self.url error:&err];
    if (err)
    {
        NSLog(@"Copy Audio File Failure: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
}

- (void)dealloc {
    [url release];
    [super dealloc];
}

+(AudioFile *)createTempAudioFile:(AudioFile *)fromAudioFile
{
    NSString* tempPath = [NSTemporaryDirectory() stringByAppendingString:@"tempAudio.caf"];
    AudioFile* temp = [[AudioFile alloc] init:tempPath];    
    if (fromAudioFile != nil)
    {
        [[NSFileManager defaultManager] 
            copyItemAtURL:fromAudioFile.url 
            toURL:[NSURL fileURLWithPath:tempPath] // Do I need to release this?
            error:nil]; // TODO: Error handle here
    }
    else
    {
        if ([temp hasData])
            [temp clearData];
    }

    return [temp autorelease];    
}

@end
