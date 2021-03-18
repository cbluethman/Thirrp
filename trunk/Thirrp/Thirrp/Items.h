//
//  Items.h
//  Thirrp
//
//  Created by Chris Bluethman on 1/22/12.
//  Copyright (c) 2012 Parastride Holdings, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Items : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * questionid;
@property (nonatomic, retain) NSNumber * viewedanswer;

@end
