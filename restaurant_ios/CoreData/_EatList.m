// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EatList.m instead.

#import "_EatList.h"

const struct EatListAttributes EatListAttributes = {
	.ate_at = @"ate_at",
};

const struct EatListRelationships EatListRelationships = {
	.food = @"food",
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
	
	if ([key isEqualToString:@"ate_atValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ate_at"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic ate_at;



- (int32_t)ate_atValue {
	NSNumber *result = [self ate_at];
	return [result intValue];
}

- (void)setAte_atValue:(int32_t)value_ {
	[self setAte_at:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveAte_atValue {
	NSNumber *result = [self primitiveAte_at];
	return [result intValue];
}

- (void)setPrimitiveAte_atValue:(int32_t)value_ {
	[self setPrimitiveAte_at:[NSNumber numberWithInt:value_]];
}





@dynamic food;

	
- (NSMutableSet*)foodSet {
	[self willAccessValueForKey:@"food"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"food"];
  
	[self didAccessValueForKey:@"food"];
	return result;
}
	






@end
