NWCoreDataHelper
================

NSManagedObject category with Core Data helper methods for retrieving and saving data

Usage

Firstly, check if this lines a correct for your Application Delegate

#import "AppDelegate.h"
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

All methods a duplicated for use with separate Core Data context or root context (appDelegate.managedObjectContext)


Then in code simply use:

Get records with NSPredicate in context

        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat:@"userId = %@", appDelegate.manager.userId];
        NSMutableArray *array =  [NSManagedObject getFilteredRecordsWithPredicate:predicate localContext:localContext];

Get all recrods 

        NSMutableArray *array = [NSManagedObject getAllRecords];


Create entity

        YourNiceObjectName *ts = [YourNiceObjectName createEntityInContext:localContext];


Save default context

        [NSManagedObject saveDefaultContext];

Save in separate context:

        [Chainge saveDataInBackgroundWithContext:^(NSManagedObjectContext *context) {
                        // your code for creating/updating data
                        //changes automatically merging in default context
                    } completion:^{
                        //your code
                        [Chainge saveDefaultContext]; //optional save default context
                       
                    }];
