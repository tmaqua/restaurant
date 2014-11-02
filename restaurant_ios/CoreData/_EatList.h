// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EatList.h instead.

#import <CoreData/CoreData.h>


extern const struct EatListAttributes {
	__unsafe_unretained NSString *ate_at;
} EatListAttributes;

extern const struct EatListRelationships {
	__unsafe_unretained NSString *food;
} EatListRelationships;

extern const struct EatListFetchedProperties {
} EatListFetchedProperties;

@class Food;



@interface EatListID : NSManagedObjectID {}
@end

@interface _EatList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EatListID*)objectID;





@property (nonatomic, strong) NSNumber* ate_at;



@property int32_t ate_atValue;
- (int32_t)ate_atValue;
- (void)setAte_atValue:(int32_t)value_;

//- (BOOL)validateAte_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *food;

- (NSMutableSet*)foodSet;





@end

@interface _EatList (CoreDataGeneratedAccessors)

- (void)addFood:(NSSet*)value_;
- (void)removeFood:(NSSet*)value_;
- (void)addFoodObject:(Food*)value_;
- (void)removeFoodObject:(Food*)value_;

@end

@interface _EatList (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAte_at;
- (void)setPrimitiveAte_at:(NSNumber*)value;

- (int32_t)primitiveAte_atValue;
- (void)setPrimitiveAte_atValue:(int32_t)value_;





- (NSMutableSet*)primitiveFood;
- (void)setPrimitiveFood:(NSMutableSet*)value;


@end
