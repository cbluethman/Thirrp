//
//  ThankYouViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 6/26/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerViewController.h"
#import "ThirrpAppDelegate.h"

@interface ThankYouViewController : UIViewController
{
  AnswerViewController* _vcAnswer;
  IBOutlet UITextView *_tvQuestion;
  ThirrpAppDelegate* _app;
}

- (void)answerQuestion;

@end
