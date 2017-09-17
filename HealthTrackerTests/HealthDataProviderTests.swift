//
//  HealthDataProviderTests.swift
//  HealthTrackerTests
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import XCTest
@testable import HealthTracker

class HealthDataProviderTests: XCTestCase {
	
    override func setUp() {
        super.setUp()
    }
	
	func testEmpty() {
		
		let dataProvider = HealthDataProvider(withStore: MockHealthStore())
		
		let expect = expectation(description: "dataProvider")
		dataProvider.data(for: Date(), interval: .month) { result in
			
			XCTAssertTrue(result.isEmpty)
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 2)
	}
	
	func testEmptyWithItems() {
		
		let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
		
		let store = MockHealthStore()
		store.add(nutrient: Nutrient(name: "Apple", quantity: 2.0, units: "pieces"), forDate: yesterday)
		store.add(nutrient: Nutrient(name: "Orange", quantity: 1.0, units: "pieces"), forDate: yesterday)
		
		let dataProvider = HealthDataProvider(withStore: store)
		
		let expect = expectation(description: "dataProvider")
		dataProvider.data(for: Date(), interval: .month) { result in
			
			XCTAssertTrue(result.isEmpty)
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 2)
	}
	
	func testNutrientExists() {
		
		let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
		
		let store = MockHealthStore()
		store.add(nutrient: Nutrient(name: "Apple", quantity: 2.0, units: "pieces"), forDate: yesterday)
		store.add(nutrient: Nutrient(name: "Orange", quantity: 1.0, units: "pieces"), forDate: yesterday)
		
		let dataProvider = HealthDataProvider(withStore: store)
		
		let expect = expectation(description: "dataProvider")
		dataProvider.data(for: yesterday, interval: .day) { result in
			
			XCTAssertEqual(result.count, 2)
			XCTAssertNotNil(result.first { $0.key == "Apple" })
			XCTAssertNotNil(result.first { $0.key == "Orange" })
			
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 2)
	}
}
