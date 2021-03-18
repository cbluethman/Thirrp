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
  ADBannerView *_iad;
@protected
  int _bannerHeight;
}
@property (retain, nonatomic) IBOutlet ADBannerView *iad;

- (void)fillCoreData;
- (void)doForeground;
- (void)adOnOrOff:(ADBannerView *)banner viz:(BOOL)v;

@end
