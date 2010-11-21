//
//  ControllerFinishedDelegate.h
//  YouTour
//
//  Created by dmorgant on 11/20/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ControllerFinishedDelegate;

@protocol ControllerFinishedDelegate <NSObject>
- (void)controllerDidFinish:(id)controller;
@end
