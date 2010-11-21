//
//  WaypointDetailsController.m
//  YouTour
//
//  Created by dmorgant on 11/20/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "WaypointDetailsController.h"
#import "Waypoint.h"
@implementation WaypointDetailsController

@synthesize waypoint, titleText, audioText, delegate;

NSString * const DEFAULT_AUDIO = @"To achieve accessibility rating, enter your audio text here.";

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    audioCell.selectionStyle = UITableViewCellSelectionStyleNone;
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.title = waypoint.title;
    titleText.text = waypoint.title;
    
    if (!waypoint.audioText)
    {
        audioText.text = DEFAULT_AUDIO;
    }
    else
    {
        audioText.text = waypoint.audioText;
    }
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

-(IBAction) saveWaypoint
{
    self.waypoint.title = titleText.text;
    
    
    [self.delegate controllerDidFinish:self];
}


-(IBAction) cancelClick
{
    [self.delegate controllerDidFinish:self];
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
    [super dealloc];
}


@end
