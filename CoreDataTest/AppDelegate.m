//
//  AppDelegate.m
//  CoreDataTest
//
//  Created by admin on 3/4/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "Application.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    self.manageModel=[NSManagedObjectModel mergedModelFromBundles:nil];
    
    self.storeCoordinator=[[NSPersistentStoreCoordinator alloc]  initWithManagedObjectModel:self.manageModel];
    
    NSString* path=[NSString stringWithFormat:@"%@/%@",[self applicationDocumentsDirectory], @"test.sqlite"];
    
    NSURL* fileURL=[NSURL fileURLWithPath:path];
    NSError* error;
    [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:nil error:&error];
    
    self.managedContex =[NSManagedObjectContext new];
    [self.managedContex setPersistentStoreCoordinator:self.storeCoordinator];
    
    
   // Application* myApplication=[NSEntityDescription insertNewObjectForEntityForName:@"Application" inManagedObjectContext:self.managedContex];
    //NSLog(@"%@",myApplication);
    
    //myApplication.name=@"Test3";
    //myApplication.price=[NSNumber numberWithFloat:0.7];
    
    //[self.managedContex save:&error];
    
    
    // NSLog(@"%@",myApplication);
    
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Application" inManagedObjectContext:self.managedContex];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    
    [request setEntity:entityDescription];
    
    
    //[request setPredicate:[NSPredicate predicateWithFormat:@"name == 'Test3'"]];
    
    [request setPredicate:[NSPredicate predicateWithValue:true]];
    
    
    NSArray *array = [self.managedContex executeFetchRequest:request error:&error];
    
    
    
    for (NSManagedObject *Application in array)
    {
        NSLog(@"Name: %@", [Application valueForKey:@"name"]);
        NSLog(@"Price: %@", [Application valueForKey:@"price"]);
        /*if([[Application valueForKey:@"name"] isEqual: @"Test3"])
         {
         [self.managedContex deleteObject:Application];
         [self.managedContex save:&error];
         break;
         
         }*/
        
    
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    
    
    
    
    self.fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedContex sectionNameKeyPath:nil cacheName:nil];
    
  
    
    
    [self.fetchResultController performFetch:&error];
    
      
    for (NSUInteger i=0; i<[[self.fetchResultController fetchedObjects] count]; i++)
    {
        NSLog(@"Name: %@", [[[self.fetchResultController fetchedObjects] objectAtIndex:i] valueForKey:@"name"]);
        NSLog(@"Price: %@", [[[self.fetchResultController fetchedObjects] objectAtIndex:i] valueForKey:@"price"]);
               
        
    }
    
    
    
    return YES;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
