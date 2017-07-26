//
//  HealthKitManager.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {

	var healthStore: HKHealthStore

	init() {

		healthStore = HKHealthStore()
		healthStore.requestAuthorization(toShare: nil, read: readTypes()) { (success, _) in
		}
	}

	private func readTypes() -> Set<HKObjectType> {

		return [HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryCholesterol)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryFiber)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!,
		        HKQuantityType.quantityType(forIdentifier: .dietarySodium)!,
		        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminA)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB12)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB6)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminC)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminD)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminE)!,
		        HKQuantityType.quantityType(forIdentifier: .dietaryVitaminE)!]
	}
}
