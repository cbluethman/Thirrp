//
//  AboutViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 5/14/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/ADBannerView.h>
#import "ThirrpAppDelegate.h"

@interface AboutViewController : UIViewController < ADBannerViewDelegate >
{
@private
  ThirrpAppDelegate* _app;
	BOOL _bannerIsVisible;
  ADBannerView *_iadAbout;
  CGRect _orgRect;
@protected
  int _bannerHeight;
}
@property (retain, nonatomic) IBOutlet ADBannerView *iadAbout;

- (void)fillCoreData;
- (void)adOnOrOff:(ADBannerView *)banner viz:(BOOL)v;
- (void)doForeground;
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave;

@end
