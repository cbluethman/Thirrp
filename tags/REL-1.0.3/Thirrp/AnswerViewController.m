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
 _isDoubleAnswering = NO;
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

  if ( NO == _isDoubleAnswering )
  {
    _isDoubleAnswering = YES;
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
      
      NSString *encoded = [PHLUtility URLEncode:str];
      
      [_app.proxy AnswerQuestionWithstrquestionid:_app.askQuestionId stranswer: encoded];
      
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString( @"Thanks", @"Thanks" )
        message:NSLocalizedString( @"I'll send you a push notification when I come up with the answer to your question.\n\nI'm way behind on answering questions, do you think you can help me answer another one?", @"I'll send you a push notification when I come up with the answer to your question.\n\nI'm way behind on answering questions, do you think you can help me answer another one?" )
        delegate:self
        cancelButtonTitle:nil
        otherButtonTitles:nil];
      
      [alert addButtonWithTitle:NSLocalizedString( @"Yes", @"Yes" )];
      [alert addButtonWithTitle:NSLocalizedString( @"No", @"No" )];
      [alert show];
      [alert release];
    }

    _isDoubleAnswering = NO;
  }
     
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  UINavigationController *nc = self.navigationController;
  
  if ( 0 == buttonIndex )
  {
    [nc popViewControllerAnimated:YES];
  }
  else if ( 1 == buttonIndex )
  {
    self.tabBarController.selectedIndex = 0;
    [nc popToRootViewControllerAnimated:YES];
  }
  else
  {
    NSLog( @"Button error" );
  }

}

@end
