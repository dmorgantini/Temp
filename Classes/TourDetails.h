//
//  TourDetails.h
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TourDetails : NSObject {
	NSString* tourName;
	NSString* tourDetails;
	int tourRating;
}

@property (nonatomic, retain) NSString* tourName;
@property (nonatomic, retain) NSString* tourDetails;
@property (nonatomic) int tourRating;

@end
