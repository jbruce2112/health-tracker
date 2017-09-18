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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
	
	func testEmpty() {
		
		let provider = MockHealthDataProvider()
		
		let expect = expectation(description: "health provider")
		
		provider.data(for: Date(), interval: .month) { result in
			
			XCTAssertTrue(result.isEmpty)
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 1)
	}
	
	func testEmptyWithItems() {
		
		let provider = MockHealthDataProvider()
		
		let tomorrow = NSCalendar.current.date(byAdding: .day, value: 1, to: Date())!
		provider.dataStore[tomorrow] = Nutrient(name: "Apple", quantity: 1.0, units: "pieces")
		
		let expect = expectation(description: "health provider")
		
		let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
		provider.data(for: yesterday, interval: .day) { result in
			
			XCTAssertTrue(result.isEmpty)
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 1)
	}
}
