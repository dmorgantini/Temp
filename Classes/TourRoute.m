//
//  TourRoute.m
//  YouTour
//
//  Created by dmorgant on 11/8/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "TourRoute.h"


@implementation TourRoute

@synthesize locations;

-(TourRoute*) init
{
    self = [super init];
    
    if (self)
    {
        [locations init];
    }
    return self;
}

-(void) addLocation:(CLLocation *)location
{
    [self.locations addObject:location];
    
}

- (void)dealloc {
    self.locations = nil;
    [super dealloc];
}

@end
