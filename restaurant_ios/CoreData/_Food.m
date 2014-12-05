// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.m instead.

#import "_Food.h"

const struct FoodAttributes FoodAttributes = {
	.calory = @"calory",
	.category = @"category",
	.food_id = @"food_id",
	.green = @"green",
	.image_path = @"image_path",
	.name = @"name",
	.price = @"price",
	.red = @"red",
	.salt = @"salt",
	.yellow = @"yellow",
};

const struct FoodRelationships FoodRelationships = {
	.eatlist = @"eatlist",
};

const struct FoodFetchedProperties FoodFetchedProperties = {
};

@implementation FoodID
@end

@implementation _Food

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Food";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Food" inManagedObjectContext:moc_];
}

- (FoodID*)objectID {
	return (FoodID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"caloryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"calory"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"categoryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"category"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"food_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"food_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"greenValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"green"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"redValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"red"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"saltValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"salt"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"yellowValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"yellow"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic calory;



- (float)caloryValue {
	NSNumber *result = [self calory];
	return [result floatValue];
}

- (void)setCaloryValue:(float)value_ {
	[self setCalory:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveCaloryValue {
	NSNumber *result = [self primitiveCalory];
	return [result floatValue];
}

- (void)setPrimitiveCaloryValue:(float)value_ {
	[self setPrimitiveCalory:[NSNumber numberWithFloat:value_]];
}





@dynamic category;



- (int16_t)categoryValue {
	NSNumber *result = [self category];
	return [result shortValue];
}

- (void)setCategoryValue:(int16_t)value_ {
	[self setCategory:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCategoryValue {
	NSNumber *result = [self primitiveCategory];
	return [result shortValue];
}

- (void)setPrimitiveCategoryValue:(int16_t)value_ {
	[self setPrimitiveCategory:[NSNumber numberWithShort:value_]];
}





@dynamic food_id;



- (int16_t)food_idValue {
	NSNumber *result = [self food_id];
	return [result shortValue];
}

- (void)setFood_idValue:(int16_t)value_ {
	[self setFood_id:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveFood_idValue {
	NSNumber *result = [self primitiveFood_id];
	return [result shortValue];
}

- (void)setPrimitiveFood_idValue:(int16_t)value_ {
	[self setPrimitiveFood_id:[NSNumber numberWithShort:value_]];
}





@dynamic green;



- (float)greenValue {
	NSNumber *result = [self green];
	return [result floatValue];
}

- (void)setGreenValue:(float)value_ {
	[self setGreen:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveGreenValue {
	NSNumber *result = [self primitiveGreen];
	return [result floatValue];
}

- (void)setPrimitiveGreenValue:(float)value_ {
	[self setPrimitiveGreen:[NSNumber numberWithFloat:value_]];
}





@dynamic image_path;






@dynamic name;






@dynamic price;



- (int16_t)priceValue {
	NSNumber *result = [self price];
	return [result shortValue];
}

- (void)setPriceValue:(int16_t)value_ {
	[self setPrice:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result shortValue];
}

- (void)setPrimitivePriceValue:(int16_t)value_ {
	[self setPrimitivePrice:[NSNumber numberWithShort:value_]];
}





@dynamic red;



- (float)redValue {
	NSNumber *result = [self red];
	return [result floatValue];
}

- (void)setRedValue:(float)value_ {
	[self setRed:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveRedValue {
	NSNumber *result = [self primitiveRed];
	return [result floatValue];
}

- (void)setPrimitiveRedValue:(float)value_ {
	[self setPrimitiveRed:[NSNumber numberWithFloat:value_]];
}





@dynamic salt;



- (float)saltValue {
	NSNumber *result = [self salt];
	return [result floatValue];
}

- (void)setSaltValue:(float)value_ {
	[self setSalt:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveSaltValue {
	NSNumber *result = [self primitiveSalt];
	return [result floatValue];
}

- (void)setPrimitiveSaltValue:(float)value_ {
	[self setPrimitiveSalt:[NSNumber numberWithFloat:value_]];
}





@dynamic yellow;



- (float)yellowValue {
	NSNumber *result = [self yellow];
	return [result floatValue];
}

- (void)setYellowValue:(float)value_ {
	[self setYellow:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveYellowValue {
	NSNumber *result = [self primitiveYellow];
	return [result floatValue];
}

- (void)setPrimitiveYellowValue:(float)value_ {
	[self setPrimitiveYellow:[NSNumber numberWithFloat:value_]];
}





@dynamic eatlist;

	






@end
