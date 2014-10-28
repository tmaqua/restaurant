#import "EatList.h"


@interface EatList ()

// Private interface goes here.

@end


@implementation EatList


- (EatList*)createEatList:(int)food_id created_at:(int)created_at{
    EatList *newEatList = [EatList MR_createEntity];
    newEatList.food_id =  [[NSNumber alloc] initWithInt:food_id];
    newEatList.created_at =  [[NSNumber alloc] initWithInt:created_at];
//    newEatList.deleted_at =  [[NSNumber alloc] initWithInt:deleted_at];
    newEatList.deleted_at =  [[NSNumber alloc] initWithInt:-1];
    
    return newEatList;
}

- (NSArray*)findAllForEatList{
    return [EatList MR_findAll];
}

- (NSArray*)findDataFromDate:(int)serchDate{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"created_at == %@", serchDate];
    return [EatList MR_findAllWithPredicate:predicate];
}

- (void)deleteAllComplete{
    [EatList MR_truncateAll];
}

- (void)deletAtComlete:(EatList*)deleteList{
    [deleteList MR_deleteEntity];
}

@end
