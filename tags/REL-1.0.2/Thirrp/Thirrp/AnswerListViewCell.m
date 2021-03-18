//
//  AnswerListViewCell.m
//  Thirrp
//
//  Created by Chris Bluethman on 10/9/11.
//  Copyright (c) 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AnswerListViewCell.h"

@implementation AnswerListViewCell

@synthesize question=question_;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  
  if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])
  { 
    question_ = [[UITextField alloc] initWithFrame:CGRectZero]; 

    [question_ setOpaque:YES]; 
    [question_ setTextColor:[UIColor blackColor]]; 
    [question_ setFont:[UIFont systemFontOfSize:18]]; 
    [question_ setEnabled:NO]; 

    [self.contentView addSubview:question_];
  } 

  return self;  
} 

- (void)layoutSubviews 
{ 
  [super layoutSubviews];
  
  CGFloat f;
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
  {
    f = 768.0;    
  }
  else
  {
    f = 320.0;   
  }

  [question_ setFrame: CGRectMake( 0.0, 0.0, f, 44.0 )];
}

- (void)dealloc 
{ 
  [question_ removeFromSuperview]; 
  [question_ release];
  
  [super dealloc]; 
} 

@end
