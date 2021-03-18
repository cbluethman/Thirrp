//
//  AnswerListViewController_iPad.m
//  Thirrp
//
//  Created by Chris Bluethman on 7/4/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AnswerListViewController_iPad.h"


@implementation AnswerListViewController_iPad

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
  [_vcSeeAnswer release];
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
    [super viewDidLoad];

  _vcSeeAnswer = [[SeeAnswerViewController_iPad alloc] initWithNibName:@"SeeAnswerViewController_iPad" bundle:nil];
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

@end
