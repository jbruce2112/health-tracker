//
//  NutritionViewController.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import UIKit
import HealthKit

class NutritionViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	@IBOutlet var tabBar: UITabBar!
	
	var healthKitManager: HealthKitManager!
	
	fileprivate var compareInterval = CompareInterval.day
	fileprivate var nutrients: [(Nutrient?, Nutrient?)]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		tabBar.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	
		refresh()
	}
	
	func refresh() {
		
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
		
		healthKitManager.data(for: prior, interval: compareInterval) { priorResult in
			
			self.healthKitManager.data(for: now, interval: self.compareInterval) { currentResult in
				
				var newNutrients = [String: (Nutrient?, Nutrient?)]()
				
				// Combine the two days of results into the dictionary
				currentResult.forEach { newNutrients[$0] = ($1, nil) }
				priorResult.forEach { newNutrients[$0] = (newNutrients[$0]?.0, $1) }
				
				// Sort the dictionary by key (nutrient name) and then extract the values
				self.nutrients = newNutrients.sorted(by: { $0.0 < $1.0 }).map { $1 }
				self.tableView.reloadData()
			}
		}
	}
}

// MARK: UITableViewDataSource conformance
extension NutritionViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return nutrients?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
		
		guard
			let nutrients = nutrients,
			let idx = nutrients.count > indexPath.row ? indexPath.row : nil,
			let name = nutrients[idx].0?.name ?? nutrients[idx].1?.name,
			let units = nutrients[idx].0?.units ?? nutrients[idx].1?.units else {
			return cell
		}
		
		let current = nutrients[idx].0
		let prior = nutrients[idx].1
		
		cell.textLabel?.text = name
		
		let priorQuantity = prior?.quantity ?? 0
		let currentQuantity = current?.quantity ?? 0
		let change = currentQuantity - priorQuantity
		
		let qualifier = change >= 0 ? "more" : "fewer"
		cell.detailTextLabel?.text = "\(Int(abs(change))) \(units) \(qualifier)"
		
		return cell
	}	
}

// MARK: UITabBarDelegate conformance
extension NutritionViewController: UITabBarDelegate {
	
	func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		
		switch item.tag {
		case 1 : compareInterval = .day
		case 2 : compareInterval = .week
		case 3 : compareInterval = .month
		case 4 : compareInterval = .year
		default: compareInterval = .day
		}
		
		refresh()
	}
}
