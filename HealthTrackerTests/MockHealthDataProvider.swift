//
//  MockHealthDataProvider.swift
//  HealthTrackerTests
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
@testable import HealthTracker

class MockHealthDataProvider: HealthDataProviderProtocol {
	
	var dataStore = [Date: Nutrient]()
	
	func data(for date: Date, interval: CompareInterval, completion: @escaping ([String : Nutrient]) -> Void) {
		
		var calInterval: Calendar.Component
		switch interval {
		case .day:
			calInterval = .day
		case .week:
			calInterval = .weekOfYear
		case .month:
			calInterval = .month
		case .year:
			calInterval = .year
		}
		
		let start = date
		let end = NSCalendar.current.date(byAdding: calInterval, value: -1, to: start)!
		var results = [String: Nutrient]()
		
		for (date, nutrient) in dataStore {
			if date >= start && date <= end {
				results[nutrient.name] = nutrient
			}
		}
		completion(results)
	}
}
