// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EatList.m instead.

#import "_EatList.h"

const struct EatListAttributes EatListAttributes = {
	.created_at = @"created_at",
	.deleted_at = @"deleted_at",
	.food_id = @"food_id",
};

const struct EatListRelationships EatListRelationships = {
};

const struct EatListFetchedProperties EatListFetchedProperties = {
};

@implementation EatListID
@end

@implementation _EatList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EatList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EatList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EatList" inManagedObjectContext:moc_];
}

- (EatListID*)objectID {
	return (EatListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"created_atValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"created_at"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"deleted_atValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleted_at"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"food_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"food_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic created_at;



- (int16_t)created_atValue {
	NSNumber *result = [self created_at];
	return [result shortValue];
}

- (void)setCreated_atValue:(int16_t)value_ {
	[self setCreated_at:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCreated_atValue {
	NSNumber *result = [self primitiveCreated_at];
	return [result shortValue];
}

- (void)setPrimitiveCreated_atValue:(int16_t)value_ {
	[self setPrimitiveCreated_at:[NSNumber numberWithShort:value_]];
}





@dynamic deleted_at;



- (int16_t)deleted_atValue {
	NSNumber *result = [self deleted_at];
	return [result shortValue];
}

- (void)setDeleted_atValue:(int16_t)value_ {
	[self setDeleted_at:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveDeleted_atValue {
	NSNumber *result = [self primitiveDeleted_at];
	return [result shortValue];
}

- (void)setPrimitiveDeleted_atValue:(int16_t)value_ {
	[self setPrimitiveDeleted_at:[NSNumber numberWithShort:value_]];
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










@end
