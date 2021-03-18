//
//  AskViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirrpAppDelegate.h"
#import "ThankYouViewController.h"
#import "AnswerViewController.h"


@interface AskViewController : UIViewController <UITextViewDelegate>
{
  IBOutlet UITextView *_tvQuestion;
  IBOutlet UIBarButtonItem *_bbiCancel;
  IBOutlet UIBarButtonItem *_bbiSend;

@protected
  ThirrpAppDelegate* _app;
  ThankYouViewController* vcThankYou;
}

- (IBAction)cancelClicked:(id)sender;
- (IBAction)saveClicked:(id)sender;
- (void)textViewDidChange:(UITextView *)textView;
- (void)addQuestionToCoreData:(NSString *) strQuestion withQuestionId:(NSString *) strQuestionId;

@end
