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
-(void)toggleAudioButtons:(bool)toggle;
@end

@implementation WaypointDetailsController

// instance vars
@synthesize waypoint, titleText, audioText, delegate, navTitle, recordButton, playButton, tempAudioFile, clearButton;

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
    self.playButton.enabled = [self.tempAudioFile hasData];
}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                        successfully: (BOOL) completed {
    if (completed == YES) { // possible issue here
        self.playButton.title = @"Play";
        isPlaying = NO;
        [self toggleAudioButtons:YES];
    }
}

-(IBAction) playAudio
{
    
    if (!isPlaying)
    {
        [audioService startPlaying: tempAudioFile delegate:self];
        self.playButton.title = @"Stop";
        isPlaying = YES;
        [self toggleAudioButtons:NO];
        self.playButton.enabled = YES;
    }
    else
    {
        [audioService stopPlaying: tempAudioFile];
        self.playButton.title = @"Play";
        isPlaying = NO;
        [self toggleAudioButtons:YES];
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

-(void) stopAudioService
{
    if (isPlaying)
        [audioService stopPlaying:self.tempAudioFile];
    if (isRecording)
        [audioService stopRecording:self.tempAudioFile];
    
}

-(void) closeDetailsView
{
    [tempAudioFile clearData];
    [self.delegate controllerDidFinish:self];
}

-(IBAction) saveWaypoint
{
    [self stopAudioService];
    self.waypoint.title = titleText.text;
    if (![audioText.text isEqualToString:DEFAULT_AUDIO])
        self.waypoint.audioText = audioText.text;
    
    [self.waypoint saveAudioFile:tempAudioFile];
    [self closeDetailsView];
}

-(IBAction) cancelClick
{
    [self stopAudioService];
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
        [self toggleAudioButtons:YES];
    }
    else
    {
        [audioService startRecording: tempAudioFile];
        recordButton.title = @"Stop";
        isRecording = true;
        [self toggleAudioButtons: NO];
        self.recordButton.enabled = YES;
    }
}

-(IBAction) clearAudio
{
    // may need an alert here?
    [self.tempAudioFile clearData];
    self.playButton.enabled = false;
    
}

-(void) toggleAudioButtons:(bool) toggle
{
    self.playButton.enabled = toggle;
    self.clearButton.enabled = toggle;
    self.recordButton.enabled = toggle;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
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
    [clearButton release];
    [playButton release];
    [audioService release];
    [tempAudioFile release];
    [super dealloc];
}


@end
