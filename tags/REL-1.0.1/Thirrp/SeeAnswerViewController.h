//
//  SeeAnswerViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 12/30/11.
//  Copyright (c) 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Items.h" 
#import "ThirrpAppDelegate.h"

@interface SeeAnswerViewController : UIViewController < UITextViewDelegate >
{
@private
  ThirrpAppDelegate* _app;
  Items *currentEntry; 

@private
  UITextView *_tvQuestion;
  UITextView *_tvAnswer;
}

@property (retain, nonatomic) IBOutlet UITextView *tvQuestion;
@property (retain, nonatomic) IBOutlet UITextView *tvAnswer;

- (void)setViewEntry:(Items*)item;

@end
