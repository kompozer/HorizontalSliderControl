/*
 * Copyright 2010, Andreas Kompanez
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "HorizontalSliderControlExampleViewController.h"

@interface HorizontalSliderControlExampleViewController ()

- (void)_initControl;
- (void)_initLabel;

@end

@implementation HorizontalSliderControlExampleViewController

@synthesize controlContainerView;
@synthesize numberLabel;


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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self _initControl];
	[self _initLabel];
	
    [super viewDidLoad];
}


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
	self.controlContainerView = nil;
	self.numberLabel = nil;
}

#pragma mark -
#pragma mark HorizontalSliderControl delegate methods

- (void)horizontalSliderControlValueChanged:(NSInteger)value
{
	[[self numberLabel] setText:[NSString stringWithFormat:@"%d", value]];
}

#pragma mark -
#pragma mark Private methods

- (void)_initControl
{
	HorizontalSliderControl *horizontalSliderControl = [[HorizontalSliderControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
	[horizontalSliderControl setDelegate:self];
	[[self controlContainerView] addSubview:horizontalSliderControl];
	[horizontalSliderControl release];
}

- (void)_initLabel
{
	[self numberLabel].textColor = [UIColor whiteColor];
    [self numberLabel].shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35];
    [self numberLabel].shadowOffset = CGSizeMake(0, -1.0);
	[self numberLabel].text = @"1";
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
	[controlContainerView release];
	[numberLabel release];

    [super dealloc];
}

@end
