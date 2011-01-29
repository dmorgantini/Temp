//
//  WaypointDetailsController.m
//  YouTour
//
//  Created by dmorgant on 11/20/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "WaypointDetailsController.h"
#import "Waypoint.h"
#import "AudioService.h"
#import "AudioFile.h"

@interface WaypointDetailsController()
@property (nonatomic, retain) AudioFile* tempAudioFile;
@end

@implementation WaypointDetailsController

// instance vars
@synthesize waypoint, titleText, audioText, delegate, navTitle, recordButton, playButton, tempAudioFile;

// services
@synthesize audioService;

NSString * const DEFAULT_AUDIO = @"To achieve accessibility rating, enter your audio text here.";

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioService = [[AudioService alloc] init];
    isRecording = false;
    
    audioCell.selectionStyle = UITableViewCellSelectionStyleNone;
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.navTitle.title = waypoint.title;
    titleText.text = waypoint.title;
    
    recordButton.possibleTitles = [NSSet setWithObjects:@"Record", @"Stop", nil];
    
    if (!waypoint.audioText)
    {
        audioText.text = DEFAULT_AUDIO;
    }
    else
    {
        audioText.text = waypoint.audioText;
    }
    
    self.tempAudioFile = [AudioFile createTempAudioFile:waypoint.audioFile];
}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                        successfully: (BOOL) completed {
    if (completed == YES) { // possible issue here
        self.playButton.title = @"Play";
        isPlaying = NO;
    }
}

-(IBAction) playAudio
{
    
    if (!isPlaying)
    {
        [audioService startPlaying: tempAudioFile delegate:self];
        self.playButton.title = @"Stop";
        isPlaying = YES;
    }
    else
    {
        [audioService stopPlaying: tempAudioFile];
        self.playButton.title = @"Play";
        isPlaying = NO;
        
    }
        
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:DEFAULT_AUDIO])
        textView.text = @"";
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
        textView.text = DEFAULT_AUDIO;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (indexPath.row == 0)
    {
        cell = titleCell;
    }
    else
    {
        cell = audioCell;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if( indexPath.row == 0 ) {
        height = 44;
    } else {
        height = 156;
    }
    return height;
}

-(void) closeDetailsView
{
    [tempAudioFile clearData];
    [self.delegate controllerDidFinish:self];
}

-(IBAction) saveWaypoint
{
    self.waypoint.title = titleText.text;
    if (![audioText.text isEqualToString:DEFAULT_AUDIO])
        self.waypoint.audioText = audioText.text;
    
    [self.waypoint saveAudioFile:tempAudioFile];
    [self closeDetailsView];
}

-(IBAction) cancelClick
{
    [self closeDetailsView];
}

-(IBAction) doneTitleText
{
    // TODO: validate Title Text?
    
    self.title = titleText.text;
    [titleText resignFirstResponder];
}

-(IBAction) doneAudioText
{
    [audioText resignFirstResponder];
}

-(IBAction) recordAudio
{
    if (isRecording)
    {
        [audioService stopRecording: tempAudioFile];
        recordButton.title = @"Record";
        isRecording = false;
        self.playButton.enabled = YES;
    }
    else
    {
        [audioService startRecording: tempAudioFile];
        recordButton.title = @"Stop";
        isRecording = true;
        self.playButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    self.audioService = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [audioText release];
    [titleText release];
    [waypoint release];
    [navTitle release];
    [recordButton release];
    [playButton release];
    [audioService release];
    [tempAudioFile release];
    [super dealloc];
}


@end
