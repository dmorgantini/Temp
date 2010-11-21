//
//  WaypointDetailsController.h
//  YouTour
//
//  Created by dmorgant on 11/20/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerFinishedDelegate.h"


@class Waypoint;

@interface WaypointDetailsController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tableView;
    IBOutlet UITableViewCell *titleCell;
    IBOutlet UITableViewCell *audioCell;
    
    IBOutlet UITextView *audioText;
    IBOutlet UITextField *titleText;
    
    Waypoint* waypoint;
    
    id <ControllerFinishedDelegate> delegate;
}

@property (nonatomic, assign) id <ControllerFinishedDelegate> delegate;
@property (nonatomic, retain) UITextView *audioText;
@property (nonatomic, retain) UITextField *titleText;
@property (nonatomic, retain) Waypoint* waypoint;

-(IBAction) cancelClick;

@end
