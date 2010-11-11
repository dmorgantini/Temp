//
//  Alert.m
//  YouTour
//
//  Created by dmorgant on 10/31/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "Alert.h"


@implementation Alert

+ (void) showAlert:(NSString*) title
       withMessage:(NSString*) message {
    UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title message:message
						  delegate: self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [ alert show] ;
    [ alert autorelease];
    
}

@end
