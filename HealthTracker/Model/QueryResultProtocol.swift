//
//  QueryResultProtocol.swift
//  HealthTracker
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

protocol QueryResultProtocol {
	var result: HKQuantity? { get }
	var name: String { get }
	var units: HKUnit { get }
}

extension HKStatistics: QueryResultProtocol {
	var result: HKQuantity? {
		return sumQuantity()
	}
	
	var name: String {
		return Nutrient.supportedTypeFormats[quantityType]?.0 ?? ""
	}
	
	var units: HKUnit {
		return Nutrient.supportedTypeFormats[quantityType]?.1 ?? HKUnit.gram()
	}
}
