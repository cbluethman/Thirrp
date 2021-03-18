//
//  AskViewController.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AskViewController.h"
#import "ThankYouViewController.h"
#import "Items.h"
#import "PHLUtility.h"

@implementation AskViewController
@synthesize iad = _iad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [_app setBadge];
  [self doForeground];
}

- (void)dealloc
{
  [_tvQuestion release];
  [_bbiCancel release];
  [_bbiSend release];

  [[NSNotificationCenter defaultCenter] removeObserver:self];
  _iad.delegate = nil;
  [_iad release];
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
  
  _iad.requiredContentSizeIdentifiers = [NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
  
  _app = [[UIApplication sharedApplication] delegate];
  _bannerIsVisible = NO;
  self.iad.frame = CGRectOffset( _iad.frame, 0, _bannerHeight );      
  
  _iad.delegate = self;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doForeground) name:UIApplicationWillEnterForegroundNotification object:nil];

  [_tvQuestion setDelegate:self];
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0f green:39/255.0f blue:107/255.0f alpha:1.0f];
}


- (void)viewDidUnload
{
  [self setIad:nil];
  
  [_tvQuestion release];
  [_bbiCancel release];
  [_bbiSend release];
  _tvQuestion = nil;
  _bbiCancel = nil;
  _bbiSend = nil;

  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ( YES );
}

- (IBAction)cancelClicked:(id)sender
{
  [_tvQuestion resignFirstResponder];
  [self.tabBarController setSelectedIndex:0];
}

- (IBAction)saveClicked:(id)sender
{
  [_bbiSend setEnabled:NO];
  
  [_tvQuestion resignFirstResponder];
  
  NSString* str = [[_tvQuestion text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  
  if ( 0 == [str length] )
  {
    // Do nothing
  }
  else
  {
    _app.currentQuestion = str;
    
//    NSDate *now = [[[NSDate alloc] init] autorelease];
//    NSDateFormatter *f = [[[NSDateFormatter alloc] init] autorelease];
    
//    [f setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        
//    NSString *askDate = [f stringFromDate:now];
    
    if ( [str length] > 4096 )
    {
      str = [str substringToIndex:4096];
    }
    
    // apostrophe delemiter oddness
    str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    
    NSString *encoded = [PHLUtility URLEncode:str];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0]; 
          
    NSArray *arr = [_app.proxy InsertQuestionWithstrlocale:currentLanguage strquestion:encoded];
    
    if ( [arr count] > 0 )
    {
      NSString *insertedQuestionId = nil;
      parastr_thirrpModel_Questions *q = [[[parastr_thirrpModel_Questions alloc]init] autorelease];
      
      q = (parastr_thirrpModel_Questions*) [arr objectAtIndex:0];
      insertedQuestionId = [[q getQuestionId] description];
      
      [self addQuestionToCoreData:str withQuestionId:insertedQuestionId];
    }
    
  }
      
  UIBarButtonItem *bbiAnswer = [[[UIBarButtonItem alloc] 
                                 initWithTitle:NSLocalizedString( @"Answer",
                                 @"Answer" )
                                 style:UIBarButtonItemStyleBordered
                                 target:vcThankYou 
                                 action:@selector(answerQuestion)] autorelease]; 
  vcThankYou.navigationItem.rightBarButtonItem = bbiAnswer; 
  [vcThankYou.navigationItem setTitle:NSLocalizedString( @"Thank You",
                                                        @"Thank You" )];
  [[self navigationController] pushViewController:vcThankYou animated:YES];
    
  [_bbiSend setEnabled:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
  [_bbiSend setEnabled:[textView hasText]];
}

- (void)addQuestionToCoreData:(NSString *) strQuestion withQuestionId:(NSString *) strQuestionId
{ 
  
  /*
	 Create a new instance of the Items entity.
	 */
	Items *items = (Items *) [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:_app.managedObjectContext];

  items.question = strQuestion;
  items.questionid = strQuestionId;
  items.answer = @"";;
  items.viewedanswer = [NSNumber numberWithBool:NO];
    
  // Commit the change.
	NSError *error = nil;
  
	if (![ _app.managedObjectContext save:&error] )
  {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}

}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
  [self adOnOrOff:banner viz:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
  [self adOnOrOff:banner viz:NO];
}

- (void)doForeground
{
  
  if ( _iad.bannerLoaded )
  {
    [self adOnOrOff:_iad viz:YES];     
  }
  
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
  {
    _iad.currentContentSizeIdentifier =
    ADBannerContentSizeIdentifierLandscape;
  }
  else
  {
    _iad.currentContentSizeIdentifier =
    ADBannerContentSizeIdentifierPortrait;
  }
  
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
  return YES;
}

- (void)adOnOrOff:(ADBannerView *)banner viz:(BOOL)v
{
  
  if ( ![PHLUtility PingServer:@"http://google.com"] )
  {
    v = NO;
  }
  
  if ( v && !_bannerIsVisible )
  {
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    banner.frame = CGRectOffset(banner.frame, 0, -_bannerHeight);
    [UIView commitAnimations];
    _bannerIsVisible = YES;
  }
  
  if ( !v && _bannerIsVisible )
  {
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    banner.frame = CGRectOffset(banner.frame, 0, +_bannerHeight);
    [UIView commitAnimations];
    _bannerIsVisible = NO;
  }
  
}      

@end
