//
//  TourRoute.h
//  YouTour
//
//  Created by dmorgant on 11/8/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TourRoute : NSObject {
    NSMutableSet* locations;
}

@property (nonatomic, retain) NSMutableSet* locations;

-(void) addLocation: (CLLocation*) location;

@end
