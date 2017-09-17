//
//  HealthKitManager.swift
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

	private let healthStore: HealthStoreProtocol

	init(withStore store: HealthStoreProtocol) {
		self.healthStore = store
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
				let queryCompletionHandler: (QueryResultProtocol?) -> Void = { result in
					
					defer {
						serviceGroup.leave()
					}
					
					guard let statistic = result, let sum = statistic.result else {
						return
					}
					
					let nutrient = Nutrient(queryResult: statistic, quantity: sum)
					results[nutrient.name] = nutrient
				}
				
				let hkQuery = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
					queryCompletionHandler(result)
				}
				
				let query = Query(query: hkQuery, start: start, end: end, sampleType: sampleType, completion: queryCompletionHandler)
				self.healthStore.execute(query)
			}
			
			serviceGroup.wait()
			
			DispatchQueue.main.async {
				completion(results)
			}
		}
	}
}
