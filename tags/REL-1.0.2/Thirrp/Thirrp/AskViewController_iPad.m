//
//  AskViewController_iPad.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AskViewController_iPad.h"
#import "ThankYouViewController_iPad.h"

@implementation AskViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  _bannerHeight = 66;
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return YES;
}

- (IBAction)saveClicked:(id)sender
{
  vcThankYou = [[[ThankYouViewController_iPad alloc] initWithNibName:@"ThankYouViewController_iPad" bundle:nil] autorelease];
  
  [super saveClicked:sender];
}

@end
