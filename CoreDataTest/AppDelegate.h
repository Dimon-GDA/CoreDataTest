//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by admin on 3/4/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property  (strong, nonatomic) NSManagedObjectContext* managedContex;
@property  (strong, nonatomic) NSPersistentStoreCoordinator* storeCoordinator;
@property  (strong,nonatomic) NSManagedObjectModel* manageModel;
@property  (strong,nonatomic) NSFetchedResultsController* fetchResultController;
@end
