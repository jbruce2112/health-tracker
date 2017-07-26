//
//  Nutrient.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

struct Formatting {
	
	let name: String
	let unit: HKUnit
	
	init(_ name: String, _ unit: HKUnit) {
		self.name = name
		self.unit = unit
	}
}

struct Nutrient {
	
	let name: String
	let quantity: Double
	let units: String
	
	init(_ type: HKQuantityType, _ quantity: HKQuantity) {
		
		name = Nutrient.SupportedTypes[type]?.name ?? ""
		
		let hkUnit = Nutrient.SupportedTypes[type]?.unit ?? HKUnit.gram()
		self.quantity = quantity.doubleValue(for: hkUnit)
		self.units = hkUnit.unitString
	}
	
	static let SupportedTypes = {
		
		return [HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!: Formatting("Carbohydrates", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryCholesterol)!: Formatting("Cholesterol", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!: Formatting("Calorie Intake", HKUnit.kilocalorie()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!: Formatting("Fat Saturated", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!: Formatting("Fat Total", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryFiber)!: Formatting("Fiber", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!: Formatting("Protein", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietarySodium)!: Formatting("Sodium", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!: Formatting("Sugar", HKUnit.gram()),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminA)!: Formatting("Vitamin A", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB12)!: Formatting("Vitamin B12", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB6)!: Formatting("Vitamin B6", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminC)!: Formatting("Vitamin C", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminD)!: Formatting("Vitamin D", HKUnit.gramUnit(with: .milli)),
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminE)!: Formatting("Vitamin E", HKUnit.gramUnit(with: .milli))]
	}()
}
