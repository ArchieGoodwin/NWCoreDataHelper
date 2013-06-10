//
// Created by Nero Wolfe on 5/10/13.
//
//


#import "NSManagedObject+NWCoreDataHelper.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@implementation NSManagedObject (NWCoreDataHelper)


+(id)createEntityInContext:(NSManagedObjectContext *)localContext
{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:localContext];
    return obj;
}

+(id)createEntityInContext
{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:appDelegate.managedObjectContext];
    return obj;
}


+(void)deleteInContext:(NSManagedObject *)object localContext:(NSManagedObjectContext *)localContext
{
    [localContext deleteObject:object];
}


+(void)deleteInContext:(NSManagedObject *)object
{
    [appDelegate.managedObjectContext deleteObject:object];
}

+(id)getSingleObjectByPredicate:(NSPredicate *)predicate localContext:(NSManagedObjectContext *)localContext
{
    NSMutableArray *array = [self getFilteredRecordsWithPredicate:predicate localContext:localContext];
    if(array.count > 0)
    {
        return array[0];
    }
    return nil;
}

+(id)getSingleObjectByPredicate:(NSPredicate *)predicate
{
    NSMutableArray *array = [self getFilteredRecordsWithPredicate:predicate localContext:appDelegate.managedObjectContext];
    if(array.count > 0)
    {
        return array[0];
    }
    return nil;
}


+(NSMutableArray *)fetcher:(NSFetchRequest *)request localContext:(NSManagedObjectContext *)localContext
{
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[localContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        NSLog(@"Unresolved error while fetching in %@ :%@, %@", NSStringFromClass(self) , error, [error userInfo]);
        //exit(-1);  // Fail
    }

    return mutableFetchResults;
}


+(NSMutableArray *)getAllRecords:(NSManagedObjectContext *)localContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:localContext];
    [request setEntity:entity];

    return [self fetcher:request localContext:localContext];
}

+(NSMutableArray *)getAllRecords
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:entity];
    
    return [self fetcher:request localContext:appDelegate.managedObjectContext];
}

+(NSMutableArray *)getAllRecordsSortedBy:(NSString *)key ascending:(BOOL)ascending localContext:(NSManagedObjectContext *)localContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:localContext];
    [request setEntity:entity];

    if (key != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }

    return [self fetcher:request localContext:localContext];
}

+(NSMutableArray *)getAllRecordsSortedBy:(NSString *)key ascending:(BOOL)ascending
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:entity];
    
    if (key != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }
    
    return [self fetcher:request localContext:appDelegate.managedObjectContext];
}


+(NSMutableArray *)getFilteredRecordsWithPredicate:(NSPredicate *)predicate localContext:(NSManagedObjectContext *)localContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:localContext];
    [request setEntity:entity];
    [request setPredicate:predicate];
    return [self fetcher:request localContext:localContext];
}

+(NSMutableArray *)getFilteredRecordsWithPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:entity];
    [request setPredicate:predicate];
    return [self fetcher:request localContext:appDelegate.managedObjectContext];
}

+(NSMutableArray *)getFilteredRecordsWithSortedPredicate:(NSPredicate *)predicate key:(NSString *)key ascending:(BOOL)ascending localContext:(NSManagedObjectContext *)localContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:localContext];
    [request setEntity:entity];
    [request setPredicate:predicate];
    if (key != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }


    return [self fetcher:request localContext:localContext];
}

+(NSMutableArray *)getFilteredRecordsWithSortedPredicate:(NSPredicate *)predicate key:(NSString *)key ascending:(BOOL)ascending
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:entity];
    [request setPredicate:predicate];
    if (key != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }
    
    
    return [self fetcher:request localContext:appDelegate.managedObjectContext];
}


+ (void)saveDataInContext:(void(^)(NSManagedObjectContext *context))saveBlock
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setParentContext:appDelegate.managedObjectContext];
    [context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];				
    [appDelegate.managedObjectContext setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(mergeChangesFromNotification:)
                               name:NSManagedObjectContextDidSaveNotification
                             object:context];


    saveBlock(context);										
    NSError * error = nil;

    if ([context hasChanges])								
    {
        if(![context save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }


}


+(void)saveDefaultContext
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSError * error = nil;
        if(![appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }];

    
    
}

+ (void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self saveDataInContext:saveBlock];

        dispatch_sync(dispatch_get_main_queue(), ^{
            completion();
        });
    });
}

+ (void) mergeChangesFromNotification:(NSNotification *)notification
{
    //NSLog(@"[notification userInfo] %@", [notification userInfo]);
    NSManagedObjectContext *context = (NSManagedObjectContext *)notification.object;

    NSLog(@"Merging changes to %@context%@",
            context == appDelegate.managedObjectContext ? @"*** DEFAULT *** " : @"",
            ([NSThread isMainThread] ? @" *** on Main Thread ***" : @""));

    [appDelegate.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];

}

@end
