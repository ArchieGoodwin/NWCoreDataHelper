# NWCoreDataHelper
================

NSManagedObject category with Core Data helper methods for retrieving and saving data. Has method to save in separated thread

### Usage

Firstly, check if this lines a correct for your Application Delegate

``` objective-c
#import "AppDelegate.h"
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
```

All methods a duplicated for use with separate Core Data context or root context (appDelegate.managedObjectContext)


Then in code simply use:

### Get records with NSPredicate in context

``` objective-c
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat:@"userId = %@", appDelegate.manager.userId];
        NSMutableArray *array =  [NSManagedObject getFilteredRecordsWithPredicate:predicate localContext:localContext];
```
### Get all recrods 

``` objective-c
        NSMutableArray *array = [NSManagedObject getAllRecords];
```

### Create entity

``` objective-c
        YourNiceObjectName *ts = [YourNiceObjectName createEntityInContext:localContext];
```

### Save default context

``` objective-c
        [NSManagedObject saveDefaultContext];
```

### Save in separate context:

``` objective-c
        [NSManagedObject saveDataInBackgroundWithContext:^(NSManagedObjectContext *context) {
                        // your code for creating/updating data
                        //changes automatically merging in default context
                    } completion:^{
                        //your code
                        [Chainge saveDefaultContext]; //optional save default context
                       
                    }];
```
