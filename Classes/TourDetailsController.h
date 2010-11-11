//
//  TourDetailsController.h
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tour;

@interface TourDetailsController : UIViewController {
	Tour *tour;
	UINavigationItem *navTitle;
	UITextField *tourName;
	UITextView *tourDescription;
}

@property (nonatomic, retain) IBOutlet UINavigationItem* navTitle;
@property (nonatomic, retain) Tour* tour;
@property (nonatomic, retain) IBOutlet UITextField* tourName;
@property (nonatomic, retain) IBOutlet UITextView* tourDescription;

-(IBAction)doneClick:(id)sender;
-(IBAction)cancelClick:(id)sender;

@end
