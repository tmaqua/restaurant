// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *food_id;
	__unsafe_unretained NSString *green;
	__unsafe_unretained NSString *image_path;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *red;
	__unsafe_unretained NSString *yellow;
} FoodAttributes;

extern const struct FoodRelationships {
	__unsafe_unretained NSString *eatlist;
} FoodRelationships;

extern const struct FoodFetchedProperties {
} FoodFetchedProperties;

@class EatList;










@interface FoodID : NSManagedObjectID {}
@end

@interface _Food : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodID*)objectID;





@property (nonatomic, strong) NSNumber* category;



@property int16_t categoryValue;
- (int16_t)categoryValue;
- (void)setCategoryValue:(int16_t)value_;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* food_id;



@property int16_t food_idValue;
- (int16_t)food_idValue;
- (void)setFood_idValue:(int16_t)value_;

//- (BOOL)validateFood_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* green;



@property float greenValue;
- (float)greenValue;
- (void)setGreenValue:(float)value_;

//- (BOOL)validateGreen:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* image_path;



//- (BOOL)validateImage_path:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* price;



@property int16_t priceValue;
- (int16_t)priceValue;
- (void)setPriceValue:(int16_t)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* red;



@property float redValue;
- (float)redValue;
- (void)setRedValue:(float)value_;

//- (BOOL)validateRed:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* yellow;



@property float yellowValue;
- (float)yellowValue;
- (void)setYellowValue:(float)value_;

//- (BOOL)validateYellow:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) EatList *eatlist;

//- (BOOL)validateEatlist:(id*)value_ error:(NSError**)error_;





@end

@interface _Food (CoreDataGeneratedAccessors)

@end

@interface _Food (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCategory;
- (void)setPrimitiveCategory:(NSNumber*)value;

- (int16_t)primitiveCategoryValue;
- (void)setPrimitiveCategoryValue:(int16_t)value_;




- (NSNumber*)primitiveFood_id;
- (void)setPrimitiveFood_id:(NSNumber*)value;

- (int16_t)primitiveFood_idValue;
- (void)setPrimitiveFood_idValue:(int16_t)value_;




- (NSNumber*)primitiveGreen;
- (void)setPrimitiveGreen:(NSNumber*)value;

- (float)primitiveGreenValue;
- (void)setPrimitiveGreenValue:(float)value_;




- (NSString*)primitiveImage_path;
- (void)setPrimitiveImage_path:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (int16_t)primitivePriceValue;
- (void)setPrimitivePriceValue:(int16_t)value_;




- (NSNumber*)primitiveRed;
- (void)setPrimitiveRed:(NSNumber*)value;

- (float)primitiveRedValue;
- (void)setPrimitiveRedValue:(float)value_;




- (NSNumber*)primitiveYellow;
- (void)setPrimitiveYellow:(NSNumber*)value;

- (float)primitiveYellowValue;
- (void)setPrimitiveYellowValue:(float)value_;





- (EatList*)primitiveEatlist;
- (void)setPrimitiveEatlist:(EatList*)value;


@end
