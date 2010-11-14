//
//  Waypoint.h
//  YouTour
//
//  Created by dmorgant on 11/14/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Waypoint : NSObject <MKAnnotation>{

}

-(bool) isTooCloseToo: (Waypoint*) waypoint;

@end
