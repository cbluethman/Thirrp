//
//  ThankYouViewController.m
//  Thirrp
//
//  Created by Chris Bluethman on 6/26/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "ThankYouViewController.h"


@implementation ThankYouViewController

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
  [_tvQuestion release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  _app = [[UIApplication sharedApplication] delegate];
  
  if ( nil == _app.askQuestion )
  {
    _tvQuestion.text = @"Sorry, I don't have any questions that need answering right now!";
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
  }
  else
  {
    _tvQuestion.text = _app.askQuestion;   
  }
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  
}


- (void)viewDidUnload
{
  [_tvQuestion release];
  _tvQuestion = nil;
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ( YES );
}

- (void)answerQuestion
{
  [_vcAnswer.navigationItem setTitle:@"Answer Question"];
  
  UIBarButtonItem *bbiAnswer = [[[UIBarButtonItem alloc] 
                                 initWithTitle:@"Answer" style:
                                 UIBarButtonItemStyleBordered
                                 target:_vcAnswer 
                                 action:@selector(answerQuestion)] autorelease]; 
  _vcAnswer.navigationItem.rightBarButtonItem = bbiAnswer; 
  
  [[self navigationController] pushViewController:_vcAnswer animated:YES];

}

@end
