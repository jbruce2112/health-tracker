//
//  HealthStoreProtocol.swift
//  HealthTracker
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthStoreProtocol {
	func execute(_ query: Query)
}

extension HKHealthStore: HealthStoreProtocol {
	func execute(_ query: Query) {
		execute(query.query)
	}
}
