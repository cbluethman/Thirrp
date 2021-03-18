//
//  AnswerViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 5/14/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirrpAppDelegate.h"


@interface AnswerViewController : UIViewController <UITextViewDelegate>
{
@private
  IBOutlet UITextView *_tvAnswer;
  ThirrpAppDelegate* _app;
}

- (void)answerQuestion;

@end
