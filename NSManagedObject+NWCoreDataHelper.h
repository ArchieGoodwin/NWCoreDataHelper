//
// Created by Nero Wolfe on 5/10/13.
//
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (NWCoreDataHelper)

+(NSMutableArray *)getAllRecords:(NSManagedObjectContext *)localContext;
+(NSMutableArray *)getAllRecords;

+(NSMutableArray *)getAllRecordsSortedBy:(NSString *)key ascending:(BOOL)ascending localContext:(NSManagedObjectContext *)localContext;
+(NSMutableArray *)getAllRecordsSortedBy:(NSString *)key ascending:(BOOL)ascending;

+(NSMutableArray *)getFilteredRecordsWithPredicate:(NSPredicate *)predicate localContext:(NSManagedObjectContext *)localContext;
+(NSMutableArray *)getFilteredRecordsWithPredicate:(NSPredicate *)predicate;

+(NSMutableArray *)getFilteredRecordsWithSortedPredicate:(NSPredicate *)predicate key:(NSString *)key ascending:(BOOL)ascending localContext:(NSManagedObjectContext *)localContext;
+(NSMutableArray *)getFilteredRecordsWithSortedPredicate:(NSPredicate *)predicate key:(NSString *)key ascending:(BOOL)ascending;

+(id)createEntityInContext:(NSManagedObjectContext *)localContext;
+(id)createEntityInContext;

+(id)getSingleObjectByPredicate:(NSPredicate *)predicate localContext:(NSManagedObjectContext *)localContext;
+(id)getSingleObjectByPredicate:(NSPredicate *)predicate;

+ (void)saveDataInBackgroundWithContext:(void(^)(NSManagedObjectContext *context))saveBlock completion:(void(^)(void))completion;
+ (void)mergeChangesFromNotification:(NSNotification *)notification;
+(void)saveDefaultContext;

+(void)deleteInContext:(NSManagedObject *)object localContext:(NSManagedObjectContext *)localContext;
+(void)deleteInContext:(NSManagedObject *)object;

@end