//
//  YouTourViewController.m
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "RootController.h"
#import "YouTourDelegate.h"
#import "Alert.h"

@implementation RootController
@synthesize createTour, resumeTour, searchForTour;

-(IBAction)createTourClick:(id) sender {
	
	YouTourDelegate *delegate = (YouTourDelegate *)[[UIApplication sharedApplication] delegate];
	
	TourDetailsController *tourDetails = [[TourDetailsController alloc] initWithNibName:@"TourDetailsController" bundle:nil];	
	tourDetails.tour = delegate.currentTour;
    tourDetails.delegate = self;
    
    [self presentModalViewController:tourDetails animated:YES];
    
	[tourDetails release];
}

-(IBAction)resumeTourClick: (id) sender {
	[Alert showAlert: @"Resume Tour" withMessage: @"Do It!!"];	
}

-(IBAction)searchForTourClick: (id) sender {
	[Alert showAlert: @"Search For Tour" withMessage: @"Do It!!"];	
}

-(void)tourDetailsControllerDidFinish: (TourDetailsController *)controller
{
    [self dismissModalViewControllerAnimated:NO];
    YouTourDelegate *delegate = (YouTourDelegate *)[[UIApplication sharedApplication] delegate];
    
    MapController *mapController = [[MapController alloc] initWithNibName:@"MapController" bundle:nil];
    mapController.tour = delegate.currentTour;
    
    [self presentModalViewController:mapController animated:YES];
    
    [mapController release];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[createTour release];
	[resumeTour release];
	[searchForTour release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
