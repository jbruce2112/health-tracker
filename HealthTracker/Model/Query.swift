//
//  Query.swift
//  HealthTracker
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation
import HealthKit

// Wrap HKQuery so we can access the query parameters
// and simulate the query ourselves in unit tests
struct Query {
	let query: HKQuery
	let start: Date?
	let end: Date?
	let sampleType: HKSampleType
	let completion: (QueryResultProtocol?) -> Void
}
