//
//  AskViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/ADBannerView.h>
#import "ThirrpAppDelegate.h"
#import "ThankYouViewController.h"
#import "AnswerViewController.h"


@interface AskViewController : UIViewController <UITextViewDelegate, ADBannerViewDelegate>
{
@private
  IBOutlet UITextView *_tvQuestion;
  IBOutlet UIBarButtonItem *_bbiCancel;
  IBOutlet UIBarButtonItem *_bbiSend;

@protected
  ThankYouViewController* vcThankYou;
  int _bannerHeight;

@private
  ThirrpAppDelegate* _app;
  BOOL _bannerIsVisible;
  ADBannerView *_iad;
}
@property (retain, nonatomic) IBOutlet ADBannerView *iad;

- (IBAction)cancelClicked:(id)sender;
- (IBAction)saveClicked:(id)sender;
- (void)textViewDidChange:(UITextView *)textView;
- (void)addQuestionToCoreData:(NSString *) strQuestion withQuestionId:(NSString *) strQuestionId;
- (void)doForeground;
- (void)adOnOrOff:(ADBannerView *)banner viz:(BOOL)v;

@end
