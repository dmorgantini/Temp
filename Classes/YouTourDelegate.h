//
//  YouTourAppDelegate.h
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootController;
@class Tour;


@interface YouTourDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootController *viewController;
	Tour *currentTour;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootController *viewController;
@property (nonatomic, retain) Tour *currentTour;


@end

