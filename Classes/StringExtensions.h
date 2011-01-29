//
//  StringExtensions.h
//  YouTour
//
//  Created by dmorgant on 12/13/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (extensions)

+ (NSString*) stringWithUUID;

@end
@implementation NSString (extensions)

+ (NSString*) stringWithUUID {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
    
    //return @"abcd-1234-5678-9120";
}

@end