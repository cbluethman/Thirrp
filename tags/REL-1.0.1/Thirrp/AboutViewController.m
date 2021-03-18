//
//  AboutViewController.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/14/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AboutViewController.h"
#import "Items.h"
#import "PHLUtility.h"

@implementation AboutViewController
@synthesize iad = _iad;

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
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [_app setBadge];
  [self doForeground];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _iad.requiredContentSizeIdentifiers = [NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
  
  _app = [[UIApplication sharedApplication] delegate];
  _bannerIsVisible = NO;
  self.iad.frame = CGRectOffset( _iad.frame, 0, _bannerHeight );      
  
  _iad.delegate = self;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
  
  // Fill up CoreData?
  if ( YES == _app.firstCoreData )
  {
    [self fillCoreData];
  }
  
}

- (void)viewDidUnload
{
  [self setIad:nil];

  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ( YES );
}

- (void)fillCoreData
{
  NSArray *arr = [_app.proxy GetQuestionsByUserId];
  Items *items;
  NSString *questionId = nil;
  NSString *question = nil;
  NSString *answer = nil;
  NSNumber *viewedanswer = nil;
  int badgecount = 0;
  parastr_thirrpModel_Questions *q = [[[parastr_thirrpModel_Questions alloc]init] autorelease];
  
  for ( id x in arr )
  {
    q = (parastr_thirrpModel_Questions*) x;
    questionId = [[q getQuestionId] description];
    question = [[q getQuestion] description];
    answer = [[q getAnswer] description];
    viewedanswer = [NSNumber numberWithBool:[[q getViewedAnswer] getbool]];
    
    items = (Items *) [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:_app.managedObjectContext];
    
    items.questionid = questionId;
    items.question = question;
    items.answer = ( nil == answer ) ? @"" : answer;
    items.viewedanswer = viewedanswer;
    
    if ( [answer length] > 0 && ( ! ( YES == [viewedanswer boolValue] ) ) )
    {
      ++badgecount;
    }
    
  }
  
  // Commit the change.
  NSError *error = nil;
  
  if (![ _app.managedObjectContext save:&error] )
  {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
  }
  
  // badge it
  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgecount];
}  // fillCoreData

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
