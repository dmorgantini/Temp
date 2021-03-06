//
//  TourDetailsController.m
//  YouTour
//
//  Created by dmorgant on 10/28/10.
//

#import "TourDetailsController.h"
#import "Tour.h"
#import "TourDetails.h"
#import "Alert.h"

@implementation TourDetailsController

@synthesize tour;
@synthesize navTitle;
@synthesize tourName;
@synthesize tourDescription, delegate;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if ([tour isNew])
	{
		[tourName setSelected: YES];
		navTitle.title = @"New Tour";
	}
	else {
		tourName.text = tour.details.tourName;
		tourDescription.text = tour.details.tourDetails;
	}
}


-(IBAction) doneClick:(id)sender {
	if ([tourName.text length] == 0 || [tourDescription.text length] == 0){
        [Alert showAlert: @"Validation Error" withMessage: @"Ensure you have entered both a name and description"];
         return;
    }    
    tour.details.tourName = tourName.text;
    tour.details.tourDetails = tourDescription.text;
    
    [self.delegate tourDetailsControllerDidFinish:self];
}

-(IBAction) cancelClick:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
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
	[tourName release];
	[tourDescription release];
	[navTitle release];
    [super dealloc];
}


@end
