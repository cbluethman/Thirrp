//
//  SeeAnswerViewController_iPad.m
//  Thirrp
//
//  Created by Chris Bluethman on 12/30/11.
//  Copyright (c) 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "SeeAnswerViewController_iPad.h"
#import "PHLUtility.h"

@implementation SeeAnswerViewController_iPad
@synthesize iad = _iad;

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

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _bannerHeight = 66;
  _iad.requiredContentSizeIdentifiers = [NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
  
  _bannerIsVisible = NO;
  self.iad.frame = CGRectOffset( _iad.frame, 0, _bannerHeight );      
  
  _iad.delegate = self;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidUnload
{
  [self setIad:nil];
  
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self doForeground];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  _iad.delegate = nil;
  [_iad release];
  [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
