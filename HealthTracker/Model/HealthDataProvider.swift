//
//  HealthDataProvider.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

enum CompareInterval {
	case day
	case week
	case month
	case year
}

protocol HealthDataProviderProtocol {
	
	func data(for date: Date, interval: CompareInterval, completion: @escaping ([String: Nutrient]) -> Void)
}

class HealthDataProvider: HealthDataProviderProtocol {

	private var healthStore: HKHealthStore

	init(withSupportFor types: Set<HKQuantityType>) {

		healthStore = HKHealthStore()
		// Gather our supported types and request authorization from the health store
		healthStore.requestAuthorization(toShare: nil, read: types) { (_, _) in }
	}
	
	func data(for date: Date, interval: CompareInterval, completion: @escaping ([String: Nutrient]) -> Void) {
		
		DispatchQueue.global().async {
			
			let serviceGroup = DispatchGroup()
			
			let cal = NSCalendar.current
			let start = cal.startOfDay(for: date)
			let end = cal.date(byAdding: .day, value: 1, to: start)
			let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
			
			var results = [String: Nutrient]()
			
			for sampleType in Nutrient.supportedTypes {
				
				serviceGroup.enter()
				
				let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
					
					defer {
						serviceGroup.leave()
					}
					
					guard let statistic = result, let sum = statistic.sumQuantity() else {
						return
					}
					
					let nutrient = Nutrient(type: statistic.quantityType, quantity: sum)
					results[nutrient.name] = nutrient
				}
				
				self.healthStore.execute(query)
			}
			
			serviceGroup.wait()
			
			DispatchQueue.main.async {
				completion(results)
			}
		}
	}
}
