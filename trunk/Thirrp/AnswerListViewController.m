//
//  AnswerListViewController.m
//  Thirrp
//
//  Created by Chris Bluethman on 7/4/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "AnswerListViewController.h"
#import "AnswerListViewCell.h"
#import "PHLUtility.h"
#import "Items.h"

@implementation AnswerListViewController

@synthesize allListItems = _allListItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 
  if (self)
  {
    // Custom initialization
  }
      
 return self;
}

- (void)dealloc
{
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

- (void)viewWillAppear:(BOOL)animated
{
 [super viewWillAppear:animated];
 [_app setBadge];

   /*
   Fetch existing items.
   Create a fetch request; find the Items entity and assign it to the request; the
   execute the fetch.
   */
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:_app.managedObjectContext]; 
  
  [request setEntity:entity];
	
  // Execute the fetch
  NSError *error = nil;
  NSMutableArray *mutableFetchResults = [[_app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
  
  if (mutableFetchResults == nil)
  {
    // Handle the error.
  }
  
  self.allListItems = mutableFetchResults;
  [mutableFetchResults release];
  [request release];
  
  [self.tableView reloadData];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [self.tableView reloadData];
}
   
   // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIBarButtonItem *bbiShare = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                 target:_vcSeeAnswer 
                                 action:@selector(share)] autorelease]; 
  
  _vcSeeAnswer.navigationItem.rightBarButtonItem = bbiShare;
  _app = [[UIApplication sharedApplication] delegate];
 _isDeleting = NO;
 _isDoublePushing = NO;
  self.tableView.dataSource = self;
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0f green:39/255.0f blue:107/255.0f alpha:1.0f];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ( YES );
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section 
{ 
  return [self.allListItems count]; 
} 

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
  static NSString *MyIdentifier = @"RootCell"; 
  AnswerListViewCell *cell = (AnswerListViewCell *)[tableView
             dequeueReusableCellWithIdentifier:MyIdentifier]; 

  if (nil == cell) 
  { 
    cell = [[[AnswerListViewCell alloc] initWithFrame:CGRectZero 
                              reuseIdentifier:MyIdentifier] 
            autorelease]; 
  } 
  
  // Get the item corresponding to the current index path and configure the table view cell.
	Items *item = (Items*) [self.allListItems objectAtIndex:indexPath.row];
  
  [[cell question] setText:item.question];
  cell.contentView.backgroundColor = [UIColor whiteColor];
  
  if ( NO == [item.viewedanswer boolValue] )
  {
    [self calcRow:item];
    
    if ( [item.answer length] > 0 )
    {
      cell.contentView.backgroundColor = [UIColor colorWithRed:251/255.0f green:248/255.0f blue:148/255.0f alpha:1.0];
    }

  }

  return cell; 
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{ 

  if ( NO == _isDoublePushing )
  {
    _isDoublePushing = YES;
    [_vcSeeAnswer setViewEntry:[self.allListItems objectAtIndex:indexPath.row]]; 
    [[self navigationController] pushViewController:_vcSeeAnswer animated:YES]; 
    _isDoublePushing = NO;
  }
  
}

- (BOOL)tableView:(UITableView *)tableView 
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{ 
  if ( indexPath.row >= [self.allListItems count] )
  {
    return NO;        
  }

  return YES; 
} 

- (void)tableView:(UITableView *)tableView 
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
      toIndexPath:(NSIndexPath *)toIndexPath 
{ 
  int idxToMove = fromIndexPath.row; 
  int idxToBe = toIndexPath.row; 
	
  Items* itemToMove = [[self.allListItems objectAtIndex:idxToMove] 
                       retain]; 
  [self.allListItems removeObjectAtIndex:idxToMove]; 
  [self.allListItems insertObject:itemToMove atIndex:idxToBe]; 
  [itemToMove release]; 
} 

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath 
{ 

  if (editingStyle == UITableViewCellEditingStyleDelete && NO == _isDeleting)
  { 
    _isDeleting = YES;
    Items *items = [self.allListItems objectAtIndex:indexPath.row];
    
    NSInteger i = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    if ( NO == [items.viewedanswer boolValue] && [items.answer length] > 0 && i > 0 )
    {
      [UIApplication sharedApplication].applicationIconBadgeNumber = --i;
      [_app setBadge];
    }
    
    [_app.proxy ArchiveQuestionWithstrquestionid:items.questionid];
    [_app.managedObjectContext deleteObject:items];
    
    // Commit the change.
    NSError *error = nil;
    
    if (![_app.managedObjectContext save:&error])
    {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    [self.allListItems removeObjectAtIndex:indexPath.row]; 
    [tableView deleteRowsAtIndexPaths: 
    [NSArray arrayWithObject:indexPath] withRowAnimation:YES]; 
    _isDeleting = NO;
  } 
  
} 

- (UITableViewCellEditingStyle) tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
  return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView 
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return NSLocalizedString( @"Archive", @"Archive" );
}

- (void)calcRow:(Items*)item
{
  NSArray *arr = [_app.proxy GetQuestionWithstrquestionid:item.questionid];
  
  if ( [arr count] > 0 )
  {
    parastr_thirrpModel_Questions *q = [[[parastr_thirrpModel_Questions alloc]init] autorelease];
    
    q = (parastr_thirrpModel_Questions*) [arr objectAtIndex:0];
    
    if ( [[q getAnswer] length] > 0 )
    {
      item.answer = [q getAnswer];
      
      // Commit the change.
      NSError *error = nil;
      
      if (![ _app.managedObjectContext save:&error] )
      {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      }
      
    }

  }

}

@end
