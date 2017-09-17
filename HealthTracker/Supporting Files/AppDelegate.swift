//
//  AppDelegate.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import UIKit
import HealthKit

class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var nutritionController: NutritionViewController!
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		let navController = window!.rootViewController as! UINavigationController
		nutritionController = navController.viewControllers.first as! NutritionViewController
		
		let healthStore = HKHealthStore()
		// Gather our supported types and request authorization from the health store
		healthStore.requestAuthorization(toShare: nil, read: Nutrient.supportedTypes) { (_, _) in }
		
		nutritionController.healthDataProvider = HealthDataProvider(withStore: healthStore)
		
		return true
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		
		nutritionController.refresh()
	}
}
