//
//  Tour.m
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "Tour.h"
#import "TourDetails.h"
#import "TourRoute.h"

@implementation Tour
@synthesize details, isNew, route;

-(Tour*) initNew {
	self = [super init];
	
    if (self) {
		self.details = [[TourDetails alloc] init];
		self.isNew = YES;
        self.route = [[TourRoute alloc] init];
        
	}
	
	return self;
}

-(void)startRecording: (CLLocationCoordinate2D)coord{
    
}

-(void) dealloc {
	[details release];
    [route release];
	[super dealloc];
}

@end
