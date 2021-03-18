//
//  SeeAnswerViewController_iPad.h
//  Thirrp
//
//  Created by Chris Bluethman on 12/30/11.
//  Copyright (c) 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "SeeAnswerViewController.h"
#import <iAd/ADBannerView.h>

@interface SeeAnswerViewController_iPad : SeeAnswerViewController < ADBannerViewDelegate >
{
@private
	BOOL _bannerIsVisible;
  ADBannerView *_iad;
@protected
  int _bannerHeight;
}
@property (retain, nonatomic) IBOutlet ADBannerView *iad;

- (void)doForeground;
- (void)adOnOrOff:(ADBannerView *)banner viz:(BOOL)v;

@end
