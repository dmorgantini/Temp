//
//  TourDetails.m
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "TourDetails.h"


@implementation TourDetails

@synthesize tourDetails;
@synthesize tourName;
@synthesize tourRating;

-(void) dealloc {
	[tourDetails release];
	[tourName release];
	[super dealloc];
}

@end
