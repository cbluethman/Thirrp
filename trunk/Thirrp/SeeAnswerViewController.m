//
//  SeeAnswerViewController.m
//  Thirrp
//
//  Created by Chris Bluethman on 12/30/11.
//  Copyright (c) 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "SeeAnswerViewController.h"
#import "SHK.h"

@implementation SeeAnswerViewController
@synthesize tvQuestion = _tvQuestion;
@synthesize tvAnswer = _tvAnswer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _app = [[UIApplication sharedApplication] delegate];
  [_tvQuestion setDelegate:self];
  [_tvAnswer setDelegate:self];
}

- (void)viewDidUnload
{
  [self setTvQuestion:nil];
  [self setTvAnswer:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ( YES );
}

- (void)dealloc
{
  [_tvQuestion release];
  [_tvAnswer release];
  [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
  NSString *answer = NSLocalizedString( @"Sorry, I'm still thinking about this one.",
                                       @"Sorry, I'm still thinking about this one." );

  if ( YES == [currentEntry.viewedanswer boolValue] )
  {
    answer = currentEntry.answer;
  }
  else
  {
    
    if ( [currentEntry.answer length] > 0 )
    {
      answer = currentEntry.answer;
        
      NSInteger i = [UIApplication sharedApplication].applicationIconBadgeNumber;
        
      if ( i > 0 )
      {
        [UIApplication sharedApplication].applicationIconBadgeNumber = --i;
        [_app setBadge];
      }

      currentEntry.viewedanswer = [NSNumber numberWithBool:YES];
      [_app.proxy DidViewAnswerWithstrquestionid:currentEntry.questionid];

      // Commit the change.
      NSError *error = nil;
        
      if (![ _app.managedObjectContext save:&error] )
      {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      }

    }

  }  // if - YES
  
  [_tvQuestion setText:currentEntry.question]; 
  [_tvAnswer setText:answer];
}

- (void)share
{
  // Create the item to share (in this example, a url)
	NSURL *url = [NSURL URLWithString:@"http://thirrp.com"];
	SHKItem *item = [SHKItem URL:url title:@"Thirrp is Awesome!"];
  
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
  
	// Display the action sheet
	[actionSheet showFromToolbar:[self navigationController].toolbar];
}

- (void)setViewEntry:(Items *)item 
{ 
  currentEntry = item;
}  

@end
