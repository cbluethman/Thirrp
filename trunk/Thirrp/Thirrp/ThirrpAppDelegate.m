//
//  ThirrpAppDelegate.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "ThirrpAppDelegate.h"
#import "AnswerListViewController.h"
#import "PHLUtility.h"
#import "TabBarController.h"

@implementation ThirrpAppDelegate

@synthesize firstCoreData=_firstCoreData;
@synthesize proxy=_proxy;
@synthesize tbc = _tbc;
@synthesize window=_window;
@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;
@synthesize currentQuestion=_currentQuestion;
@synthesize askQuestion=_askQuestion;
@synthesize askQuestionId=_askQuestionId;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  
  NSString *file = [documentsPath stringByAppendingPathComponent:@"Thirrp.sqlite"];
  _firstCoreData = ![[NSFileManager defaultManager] fileExistsAtPath:file];
  
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  
#ifdef DEBUG
  _site = @"http://dev.thirrp.com";
#else
  _site = @"http://thirrp.com";
#endif
  
  if ( NO == [PHLUtility PingServer:_site] )
  {
    [self showNetworkError];
    
    return ( NO );
  }
  
  NSString *url = _site;

  url = [url stringByAppendingString:@"/service.svc/"];
  
  _proxy = [[Entities alloc] initWithUri:url credential:nil];
  
  [self registerApp];

  // Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
   (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
  
  [self.window makeKeyAndVisible];

  return ( YES );
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
  NSString *s = [NSString stringWithFormat:@"%@", deviceToken];
  
  s = [s stringByReplacingOccurrencesOfString:@" " withString: @""];
  s = [s stringByReplacingOccurrencesOfString:@"<" withString: @""];
  s = [s stringByReplacingOccurrencesOfString:@">" withString: @""];
    
  [_proxy SavePushTokenWiths:s];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Saves changes in the application's managed object context before the application terminates.
  [self saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  [self setBadge];
  [self registerApp];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Saves changes in the application's managed object context before the application terminates.
  [self saveContext];
}

- (void)dealloc
{
  [_proxy release];
  [_window release];
  [__managedObjectContext release];
  [__managedObjectModel release];
  [__persistentStoreCoordinator release];
  [_tbc release];
  [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Thirrp" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Thirrp.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

- (void )application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{

  if ( NULL != [[userInfo objectForKey:@"aps"] objectForKey:@"badge"] )
  {
    NSString *badge = [[userInfo objectForKey:@"aps"] objectForKey:@"badge"];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [badge integerValue];
    [self setBadge];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString( @"Thirrp has come up with the answer to your question!",
        @"Thirrp has come up with the answer to your question!" )
      message:nil
      delegate:nil
      cancelButtonTitle:NSLocalizedString( @"OK", @"OK" )
      otherButtonTitles:nil];
  
    [alert show];
    [alert release];
  }
  
}

- (void)setBadge
{
    NSInteger i = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    TabBarController *tbc = ( TabBarController* ) self.window.rootViewController;
    UITabBarItem *tbi = ( UITabBarItem* ) [ tbc.tabBar.items objectAtIndex:2];
    
    tbi.badgeValue = (i < 1 ) ? nil : [NSString stringWithFormat:@"%d", i];
}


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)showNetworkError
{
  UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString( @"Internet Connection Error",
      @"Internet Connection Error" )
      message:NSLocalizedString( @"Are you connected to the Internet?",
      @"Are you connected to the Internet?" )
      delegate:nil
      cancelButtonTitle:NSLocalizedString( @"OK", @"OK" )
      otherButtonTitles:nil];
  
  [myAlert show];
  [myAlert release];
}

- (void)registerApp
{
  dispatch_queue_t queue = dispatch_get_global_queue(
    DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  dispatch_async(queue, ^{
    
    if ( YES == [PHLUtility PingServer:_site] )
    {
      // RegisterDevice
      
      NSString* udid = [[UIDevice currentDevice] uniqueIdentifier];
      NSString* strXML = [_proxy RegisterDeviceWiths:udid];
      
      if ( FAIL == [PHLUtility CheckReturnValue:strXML] )
      {
        abort( );
      }
      
    }
    else
    {
      dispatch_async(dispatch_get_main_queue(), ^{ [self showNetworkError]; });
    }
    
  });

}

@end
