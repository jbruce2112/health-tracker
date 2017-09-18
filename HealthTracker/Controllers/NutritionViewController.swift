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
	
	var nutrientViewModel: NutrientViewModelProtocol!
	
	private let tableCellID = "UITableViewCell"
	
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
		nutrientViewModel.fetch {
			self.tableView.reloadData()
		}
	}
}

// MARK: UITableViewDataSource conformance
extension NutritionViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return nutrientViewModel.rowCount(forSection: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath)
		
		cell.textLabel?.text = nutrientViewModel.name(forIndex: indexPath)
		cell.detailTextLabel?.text = nutrientViewModel.name(forIndex: indexPath)
		
		return cell
	}	
}

// MARK: UITabBarDelegate conformance
extension NutritionViewController: UITabBarDelegate {
	
	func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		
		switch item.tag {
		case 1 : nutrientViewModel.compareInterval = .day
		case 2 : nutrientViewModel.compareInterval = .week
		case 3 : nutrientViewModel.compareInterval = .month
		case 4 : nutrientViewModel.compareInterval = .year
		default: nutrientViewModel.compareInterval = .day
		}
		
		refresh()
	}
}
