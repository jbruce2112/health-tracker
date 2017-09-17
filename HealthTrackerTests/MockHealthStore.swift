//
//  MockHealthStore.swift
//  HealthTrackerTests
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit
@testable import HealthTracker

struct MocQueryResult: QueryResultProtocol {
	var quantity: HKQuantity
	var nutrientName: String
	var nutrientUnits: HKUnit
	
	var result: HKQuantity? {
		return quantity
	}
	
	var name: String {
		return nutrientName
	}
	
	var units: HKUnit {
		return nutrientUnits
	}
}

class MockHealthStore: HealthStoreProtocol {
	
	var dataStore = [Date: [Nutrient]]()
	
	// Called for each sample type
	func execute(_ query: Query) {
		
		guard let start = query.start, let end = query.end else {
			return query.completion(nil)
		}
	
		var value: Double = 0
		for (date, nutrients) in dataStore {
			if date >= start && date <= end {
				for nutrient in nutrients {
					value += nutrient.quantity
				}
			}
		}
		
		if value.isZero {
			query.completion(nil)
		} else {
			let quantity = HKQuantity(unit: HKUnit.gram(), doubleValue: value)
			let result = MocQueryResult(quantity: quantity, nutrientName: query.sampleType.description, nutrientUnits: HKUnit.gram())
			query.completion(result)
		}
	}
	
	func add(nutrient: Nutrient, forDate date: Date) {
		dataStore[date, default: []].append(nutrient)
	}
}
