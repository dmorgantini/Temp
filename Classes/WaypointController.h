//
//  WaypointController.h
//  YouTour
//
//  Created by dmorgant on 11/19/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tour;

@interface WaypointController : UIViewController<UINavigationBarDelegate, UITableViewDelegate,
UITableViewDataSource> {
    Tour *tour;
    UITableView *myTableView;
    
}

@property (nonatomic, retain) Tour *tour;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@end
