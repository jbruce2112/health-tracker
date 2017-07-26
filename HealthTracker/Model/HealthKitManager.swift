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

	private var healthStore: HKHealthStore

	init() {

		healthStore = HKHealthStore()
		
		// Gather our supported types and request authorization from the health store
		var sampleTypes = Set<HKQuantityType>()
		for type in Nutrient.SupportedTypes {
			sampleTypes.insert(type.key)
		}
		
		healthStore.requestAuthorization(toShare: nil, read: sampleTypes) { (_, _) in }
	}
	
	func data(for date: Date, completion: @escaping ([Nutrient]) -> Void) {
		
		DispatchQueue.global().async {
			
			let serviceGroup = DispatchGroup()
			
			let cal = NSCalendar.current
			let start = cal.startOfDay(for: date)
			let end = cal.date(byAdding: .day, value: 1, to: start)
			let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
			
			var results = [Nutrient]()
			
			for sampleType in Nutrient.SupportedTypes {
				
				serviceGroup.enter()
				
				let query = HKStatisticsQuery(quantityType: sampleType.key, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
					
					defer {
						serviceGroup.leave()
					}
					
					guard let statistic = result, let sum = statistic.sumQuantity() else {
						return
					}
					
					results.append(Nutrient(statistic.quantityType, sum))
				}
				
				self.healthStore.execute(query)
			}
			
			serviceGroup.wait()
			
			results.sort { $0.name < $1.name }
			
			DispatchQueue.main.async {
				completion(results)
			}
		}
	}
}
