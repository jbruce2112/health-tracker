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
	
	let healthStore: HealthStoreProtocol
	
	init(withStore store: HealthStoreProtocol) {
		self.healthStore = store
	}
	
	func data(for date: Date, interval: CompareInterval, completion: @escaping ([String : Nutrient]) -> Void) {
		completion([:])
	}
}
