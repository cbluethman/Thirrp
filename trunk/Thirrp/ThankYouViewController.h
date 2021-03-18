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
@private
  IBOutlet UITextView *_tvQuestion;
  IBOutlet UITextView *_tvThankYou;
  ThirrpAppDelegate* _app;
@protected  
  AnswerViewController* _vcAnswer;
}

- (void)answerQuestion;

@end
