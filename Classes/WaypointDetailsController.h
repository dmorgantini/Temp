//
//  WaypointDetailsController.h
//  YouTour
//
//  Created by dmorgant on 11/20/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ControllerFinishedDelegate.h"


@class Waypoint;
@class AudioService;
@class AudioFile;

@interface WaypointDetailsController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, AVAudioPlayerDelegate> {
    IBOutlet UITableView *tableView;
    IBOutlet UITableViewCell *titleCell;
    IBOutlet UITableViewCell *audioCell;
    
    IBOutlet UITextView *audioText;
    IBOutlet UITextField *titleText;
    IBOutlet UINavigationItem *navTitle;
    
    IBOutlet UIBarButtonItem *recordButton;
    IBOutlet UIBarButtonItem *playButton;
    
    Waypoint* waypoint;
    bool isRecording;
    bool isPlaying;
    AudioService* audioService;
    AudioFile* tempAudioFile;
    
    id <ControllerFinishedDelegate> delegate;
}

@property (nonatomic, assign) id <ControllerFinishedDelegate> delegate;
@property (nonatomic, retain) UITextView *audioText;
@property (nonatomic, retain) UITextField *titleText;
@property (nonatomic, retain) Waypoint* waypoint;
@property (nonatomic, retain) UINavigationItem *navTitle;
@property (nonatomic, retain) UIBarButtonItem *recordButton;
@property (nonatomic, retain) UIBarButtonItem *playButton;
@property (nonatomic, retain) AudioService* audioService;

-(IBAction) cancelClick;

@end
