//
//  WaypointController.m
//  YouTour
//
//  Created by dmorgant on 11/19/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "WaypointController.h"
#import "Tour.h"
#import "Waypoint.h"


@implementation WaypointController

@synthesize tour, myTableView, delegate;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.myTableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tour.waypointList countWaypoints];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.opaque = NO;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    
    cell.textLabel.text = [tour getWaypointAtIndex:indexPath.row].title;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


-(IBAction)doneClick:(id)sender
{
    [self.delegate controllerDidFinish:self];
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
