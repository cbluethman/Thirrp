//
//  ThirrpAppDelegate.h
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entities.h"

@interface ThirrpAppDelegate : NSObject <UIApplicationDelegate>
{
@private
  NSString *_site;
  BOOL _firstCoreData;
  UITabBarController *_tbc;
  Entities* _proxy;
  QueryOperationResponse* _response;
  NSString* _currentQuestion;
  NSString* _askQuestion;
  NSString* _askQuestionId;
}

@property (readonly, assign) BOOL firstCoreData;
@property (readonly, assign) Entities* proxy;
@property (nonatomic, retain) IBOutlet UITabBarController *tbc;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, copy) NSString* currentQuestion;
@property (nonatomic, copy) NSString* askQuestion;
@property (nonatomic, copy) NSString* askQuestionId;

- (void)saveContext;
- (void)setBadge;
- (NSURL *)applicationDocumentsDirectory;
- (void)showNetworkError;
- (void)registerApp;

@end
