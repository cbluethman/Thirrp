//
//  AnswerListViewController.h
//  Thirrp
//
//  Created by Chris Bluethman on 7/4/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirrpAppDelegate.h"
#import "SeeAnswerViewController.h"

@interface AnswerListViewController : UITableViewController < UITableViewDelegate, UITableViewDataSource >
{
@private
  ThirrpAppDelegate* _app;
  BOOL _isDeleting;
  BOOL _isDoublePushing;
  NSMutableArray *_allListItems;
@protected
  SeeAnswerViewController *_vcSeeAnswer;  
}

@property (nonatomic, retain) NSMutableArray *allListItems;

- (void)calcRow: (Items*) item;

@end
