//
//  ThankYouViewController_iPad.m
//  Thirrp
//
//  Created by Chris Bluethman on 6/26/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "ThankYouViewController_iPad.h"
#import "AnswerViewController_iPad.h"

@implementation ThankYouViewController_iPad

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void)answerQuestion
{
  _vcAnswer = [[[AnswerViewController_iPad alloc] initWithNibName:@"AnswerViewController_iPad" bundle:nil] autorelease];
  
  [super answerQuestion];

}

@end
