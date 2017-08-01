//
//  Nutrient.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

struct Nutrient {
	
	let name: String
	let quantity: Double
	let units: String
	
	init(type: HKQuantityType, quantity: HKQuantity) {
		
		name = Nutrient.supportedTypeFormats[type]?.0 ?? ""
		
		let hkUnit = Nutrient.supportedTypeFormats[type]?.1 ?? HKUnit.gram()
		self.quantity = quantity.doubleValue(for: hkUnit)
		self.units = hkUnit.unitString
	}
	
	// Expose the supported HealthKit nutrition types
	static let supportedTypes = {
		
		return Set(supportedTypeFormats.map { $0.key })
	}()
	
	// Create a mapping of supported nutrient HealthKit data types
	// to their respective display string and units appropriate for rendering
	private static let supportedTypeFormats = {
		
		return [HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!: ("Carbohydrates", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryCholesterol)!: ("Cholesterol", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!: ("Calorie Intake", HKUnit.kilocalorie()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!: ("Fat Saturated", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!: ("Fat Total", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryFiber)!: ("Fiber", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!: ("Protein", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietarySodium)!: ("Sodium", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!: ("Sugar", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminA)!: ("Vitamin A", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB12)!: ("Vitamin B12", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB6)!: ("Vitamin B6", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminC)!: ("Vitamin C", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminD)!: ("Vitamin D", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminE)!: ("Vitamin E", HKUnit.gramUnit(with: .milli))]
	}()
}
