//
//  AnswerListViewCell.h
//  Thirrp
//
//  Created by Chris Bluethman on 10/9/11.
//  Copyright (c) 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerListViewCell : UITableViewCell
{ 
  UITextField *question_;
} 

@property (nonatomic, retain) UITextField *question; 

@end
