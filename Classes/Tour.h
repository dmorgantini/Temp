//
//  Tour.h
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class TourDetails;
@class TourRoute;

@interface Tour : NSObject {
	TourDetails* details;
	bool isNew;
    TourRoute* route;
}

-(Tour*) initNew;
-(bool) addRouteLocation: (CLLocation *) newLocation;


@property (nonatomic, retain) TourDetails* details;
@property (nonatomic) bool isNew;
@property (nonatomic, retain) TourRoute* route;

@end
