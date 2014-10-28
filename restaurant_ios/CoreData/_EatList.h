// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EatList.h instead.

#import <CoreData/CoreData.h>


extern const struct EatListAttributes {
	__unsafe_unretained NSString *created_at;
	__unsafe_unretained NSString *deleted_at;
	__unsafe_unretained NSString *food_id;
} EatListAttributes;

extern const struct EatListRelationships {
} EatListRelationships;

extern const struct EatListFetchedProperties {
} EatListFetchedProperties;






@interface EatListID : NSManagedObjectID {}
@end

@interface _EatList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EatListID*)objectID;





@property (nonatomic, strong) NSNumber* created_at;



@property int16_t created_atValue;
- (int16_t)created_atValue;
- (void)setCreated_atValue:(int16_t)value_;

//- (BOOL)validateCreated_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* deleted_at;



@property int16_t deleted_atValue;
- (int16_t)deleted_atValue;
- (void)setDeleted_atValue:(int16_t)value_;

//- (BOOL)validateDeleted_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* food_id;



@property int16_t food_idValue;
- (int16_t)food_idValue;
- (void)setFood_idValue:(int16_t)value_;

//- (BOOL)validateFood_id:(id*)value_ error:(NSError**)error_;






@end

@interface _EatList (CoreDataGeneratedAccessors)

@end

@interface _EatList (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(NSNumber*)value;

- (int16_t)primitiveCreated_atValue;
- (void)setPrimitiveCreated_atValue:(int16_t)value_;




- (NSNumber*)primitiveDeleted_at;
- (void)setPrimitiveDeleted_at:(NSNumber*)value;

- (int16_t)primitiveDeleted_atValue;
- (void)setPrimitiveDeleted_atValue:(int16_t)value_;




- (NSNumber*)primitiveFood_id;
- (void)setPrimitiveFood_id:(NSNumber*)value;

- (int16_t)primitiveFood_idValue;
- (void)setPrimitiveFood_idValue:(int16_t)value_;




@end
