//
//  TabBarController.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/13/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tabbar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    UITabBarItem *tbi0 = ( UITabBarItem* ) [[self tabBar].items objectAtIndex:0];
    UITabBarItem *tbi1 = ( UITabBarItem* ) [[self tabBar].items objectAtIndex:1];
    UITabBarItem *tbi2 = ( UITabBarItem* ) [[self tabBar].items objectAtIndex:2];

    [tbi0 setTitle:NSLocalizedString(@"About", "About")];
    [tbi1 setTitle:NSLocalizedString(@"Ask Question", "Ask Question")];
    [tbi2 setTitle:NSLocalizedString(@"View Answers", "View Answers")];
  
    UINavigationController *nc = ( UINavigationController* ) [[self viewControllers] objectAtIndex:1];
    UIViewController *vc = [[nc viewControllers] objectAtIndex:0];
  
    vc.navigationItem.leftBarButtonItem.title = NSLocalizedString( @"Cancel", @"Cancel" );
    vc.navigationItem.title = NSLocalizedString( @"Ask Question", @"Ask Question" );
  
    nc = ( UINavigationController* ) [[self viewControllers] objectAtIndex:2];
    vc = [[nc viewControllers] objectAtIndex:0];
    vc.navigationItem.title = NSLocalizedString( @"View Answers", @"View Answers" );
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  NSInteger i = [UIApplication sharedApplication].applicationIconBadgeNumber;
  
  if (i > 0)
  {
    UITabBarItem *tbi = ( UITabBarItem* ) [[self tabBar].items objectAtIndex:2];
    
    tbi.badgeValue = [NSString stringWithFormat:@"%d", i];    
  }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
  {
    return ( YES );    
  }
  else
  {    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
  }

}

@end
