//
//  TestController.h
//  YouTour
//
//  Created by dmorgant on 11/16/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tour;

@interface TestController : UIViewController {
    Tour* tour;
}


@property (nonatomic, retain) Tour* tour;
-(IBAction) LogSomething;

@end
