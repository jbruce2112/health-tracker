//
//  HealthKitManager.m
//  HealthTracker
//
//  Created by John on 7/18/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

#import "HealthKitManager.h"

@interface HealthKitManager	()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end


@implementation HealthKitManager

- (id) init
{
	self = [super init];
	self.healthStore = [[HKHealthStore alloc] init];
	
	[self.healthStore requestAuthorizationToShareTypes:NULL readTypes:[HealthKitManager dataTypesToRead] completion: ^(BOOL success, NSError * error)
	 {
	 }];
	
	return self;
}

+ (NSSet<HKObjectType*> *) dataTypesToRead
{
	return [[NSSet alloc] initWithArray: @[
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryFatTotal],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryFatPolyunsaturated],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryFatMonounsaturated],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryFatSaturated],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryCholesterol],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietarySodium],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryCarbohydrates],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryFiber],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietarySugar],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryEnergyConsumed],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryProtein],
			
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminA],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminB6],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminB12],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminC],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminD],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminE],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryVitaminK],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryCalcium],
			
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryIron],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryThiamin],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryRiboflavin],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryNiacin],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryFolate],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryBiotin],
			
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryPantothenicAcid],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryPhosphorus],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryIodine],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryMagnesium],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryZinc],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietarySelenium],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryCopper],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryManganese],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryChromium],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryMolybdenum],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryChloride],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryPotassium],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryCaffeine],
			[HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierDietaryWater] ]];
}

@end
