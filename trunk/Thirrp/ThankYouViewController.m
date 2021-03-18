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
  [_tvThankYou release];
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
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
  NSString *currentLanguage = [languages objectAtIndex:0]; 

  _app = [[UIApplication sharedApplication] delegate];
  
  NSArray *arr = [ _app.proxy GetQuestionToAnswerWithstrlocale:currentLanguage ];
  
  if ( [arr count] > 0 )
  {
    parastr_thirrpModel_Questions *q = [[[parastr_thirrpModel_Questions alloc]init] autorelease];
    
    q = (parastr_thirrpModel_Questions*) [arr objectAtIndex:0];
    _app.askQuestion = [q getQuestion];
    _app.askQuestionId = [[q getQuestionId] description];
  }
  else
  {
    _app.askQuestion = nil;
  }
  
  if ( nil == _app.askQuestion )
  {
    _tvQuestion.text = NSLocalizedString( @"Sorry, I don't have any questions that need answering right now!",
                                         @"Sorry, I don't have any questions that need answering right now!" );
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
  }
  else
  {
    _tvQuestion.text = _app.askQuestion;   
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
  }
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _tvThankYou.text = NSLocalizedString( @"Wow, that is a good question.  I'm going to have to think about it and get back to you.  I'll send you a push notification when I get the answer.\n\nIn the meantime, I have a question that has been on my mind.  Do you think you can answer it for me?  Question is in yellow, below.  Press Answer at the top to answer.", @"Wow, that is a good question.  I'm going to have to think about it and get back to you.  I'll send you a push notification when I get the answer.\n\nIn the meantime, I have a question that has been on my mind.  Do you think you can answer it for me?  Question is in yellow, below.  Press Answer at the top to answer." );
}


- (void)viewDidUnload
{
  [_tvQuestion release];
  _tvQuestion = nil;
  [_tvThankYou release];
  _tvThankYou = nil;
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
  [_vcAnswer.navigationItem setTitle:NSLocalizedString( @"Answer Question", @"Answer Question" )];
  
  UIBarButtonItem *bbiAnswer = [[[UIBarButtonItem alloc] 
                                 initWithTitle:NSLocalizedString( @"Answer", @"Answer" )
                                 style:UIBarButtonItemStyleBordered
                                 target:_vcAnswer 
                                 action:@selector(answerQuestion)] autorelease]; 
  _vcAnswer.navigationItem.rightBarButtonItem = bbiAnswer; 
  
  [[self navigationController] pushViewController:_vcAnswer animated:YES];

}

@end
