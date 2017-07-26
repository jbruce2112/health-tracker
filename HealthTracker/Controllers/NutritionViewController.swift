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
	
	fileprivate var priorNutrients: [Nutrient]?
	fileprivate var currentNutrients: [Nutrient]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let now = Date()
		let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: now)!
		healthKitManager.data(for: yesterday) { yesterdayResult in
			
			self.healthKitManager.data(for: now) { todayResult in
				
				self.priorNutrients = yesterdayResult
				self.currentNutrients = todayResult
				self.tableView.reloadData()
			}
		}
	}
}

extension NutritionViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentNutrients?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
		
		guard
			let priorNutrients = priorNutrients,
			let currentNutrients = currentNutrients,
			let current = currentNutrients.count > indexPath.row ? currentNutrients[indexPath.row] : nil else {
			return cell
		}
		
		// Make sure the nutrient identifiers match
		let priorQuantity = priorNutrients.first(where: { $0.name == current.name })?.quantity ?? 0
		
		cell.textLabel?.text = current.name
		
		let change = current.quantity - priorQuantity
		let qualifier = change >= 0 ? "more" : "fewer"
		cell.detailTextLabel?.text = "\(Int(abs(change))) \(current.units) \(qualifier)"
		return cell
	}	
}
