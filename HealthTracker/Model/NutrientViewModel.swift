//
//  NutrientViewModel.swift
//  HealthTracker
//
//  Created by John on 9/17/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import Foundation

protocol NutrientViewModelProtocol {
	
	var compareInterval: CompareInterval { get set }
	
	func fetch(completion: @escaping () -> Void)
	
	func rowCount(forSection section: Int) -> Int
	func name(forIndex indexPath: IndexPath) -> String
	func delta(forIndex indexPath: IndexPath) -> String
}

class NutrientViewModel: NutrientViewModelProtocol {
	
	private let healthProvider: HealthDataProviderProtocol
	
	private var nutrients: [(Nutrient?, Nutrient?)]?
	
	var compareInterval = CompareInterval.day
	
	init(withProvider healthProvider: HealthDataProviderProtocol) {
		self.healthProvider = healthProvider
	}
	
	func fetch(completion: @escaping () -> Void) {
		
		var interval: Calendar.Component
		
		switch compareInterval {
		case .day:
			interval = .day
		case .week:
			interval = .weekOfYear
		case .month:
			interval = .month
		case .year:
			interval = .year
		}
		
		let now = Date()
		let prior = NSCalendar.current.date(byAdding: interval, value: -1, to: now)!
		
		healthProvider.data(for: prior, interval: compareInterval) { priorResult in
			
			self.healthProvider.data(for: now, interval: self.compareInterval) { currentResult in
				
				var newNutrients = [String: (Nutrient?, Nutrient?)]()
				
				// Combine the two days of results into the dictionary
				currentResult.forEach { newNutrients[$0] = ($1, nil) }
				priorResult.forEach { newNutrients[$0] = (newNutrients[$0]?.0, $1) }
				
				// Sort the dictionary by key (nutrient name) and then extract the values
				self.nutrients = newNutrients.sorted(by: { $0.0 < $1.0 }).map { $1 }
				completion()
			}
		}
	}
	
	func rowCount(forSection section: Int) -> Int {
		return nutrients?.count ?? 0
	}
	
	func name(forIndex indexPath: IndexPath) -> String {
		guard
			let nutrients = nutrients,
			let idx = nutrients.count > indexPath.row ? indexPath.row : nil,
			let name = nutrients[idx].0?.name ?? nutrients[idx].1?.name else {
				return ""
		}
		
		return name
	}
	
	func delta(forIndex indexPath: IndexPath) -> String {
		
		guard
			let nutrients = nutrients,
			let idx = nutrients.count > indexPath.row ? indexPath.row : nil,
			let units = nutrients[idx].0?.units ?? nutrients[idx].1?.units else {
				return ""
		}
		
		let current = nutrients[idx].0
		let prior = nutrients[idx].1
		
		let priorQuantity = prior?.quantity ?? 0
		let currentQuantity = current?.quantity ?? 0
		let change = currentQuantity - priorQuantity
		
		let qualifier = change >= 0 ? "more" : "fewer"
		return "\(Int(abs(change))) \(units) \(qualifier)"
	}
}
