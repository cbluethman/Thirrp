//
//  PHLUtility.h
//  PHLUtility
//
//  Created by Chris Bluethman on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCCESS 0
#define FAIL    1

@interface PHLUtility : NSObject
{

}

+ (int)CheckReturnValue:(NSString*) s;
+ (BOOL)Reachable:(NSString*) s;
+ (BOOL)PingServer:(NSString*) s;
+ (NSString*)URLEncode:(NSString*) s;

@end
