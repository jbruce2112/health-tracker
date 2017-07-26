//
//  NutritionViewController.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	@IBOutlet var tabBar: UITabBar!
	
	var healthKitManager: HealthKitManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
	}
}

extension NutritionViewController: UITableViewDelegate {
	
}

extension NutritionViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
		cell.textLabel?.text = "Nutrient \(indexPath.row)"
		cell.detailTextLabel?.text = "35% higher"
		return cell
	}
}
