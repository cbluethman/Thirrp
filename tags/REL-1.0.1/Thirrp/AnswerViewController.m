//
//  AnswerViewController.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/14/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AnswerViewController.h"
#import "PHLUtility.h"

@implementation AnswerViewController

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
  [_tvAnswer release];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
 
  _app = [[UIApplication sharedApplication] delegate];
  [_tvAnswer setDelegate:self];
}

- (void)viewDidUnload
{
  [_tvAnswer release];
  _tvAnswer = nil;
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
  [_tvAnswer resignFirstResponder];
  
  NSString* str = [[_tvAnswer text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  
  if ( 0 == [str length] )
  {
    // Do nothing
  }
  else
  {

    if ( [str length] > 4096 )
    {
      str = [str substringToIndex:4096];
    }
    
    // apostrophe delemiter oddness
    str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    
    NSString *Encoded = [PHLUtility URLEncode:str];
    
    [_app.proxy AnswerQuestionWithstrquestionid:_app.askQuestionId stranswer: Encoded];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks.  I'll send you a push notification when I come up with the answer to your question."
      message:nil
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil];
 
		[alert show];
    [alert release];
    
    UINavigationController *nc = self.navigationController;
    
    self.tabBarController.selectedIndex = 0;
    [nc popToRootViewControllerAnimated:NO];
   }
     
}

@end
