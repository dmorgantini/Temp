//
//  YouTourViewController.h
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourDetailsController.h"
#import "MapController.h"

@interface RootController : UIViewController <TourDetailsControllerDelegate> {
	UIButton *createTour;
	UIButton *searchForTour;
	UIButton *resumeTour;
}

@property (nonatomic, retain) IBOutlet UIButton *createTour;
@property (nonatomic, retain) IBOutlet UIButton *searchForTour;
@property (nonatomic, retain) IBOutlet UIButton *resumeTour;

-(IBAction)createTourClick:(id)sender;
-(IBAction)searchForTourClick: (id)sender;
-(IBAction)resumeTourClick: (id)sender;

@end

