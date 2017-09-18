//
//  AppDelegate.swift
//  HealthTracker
//
//  Created by John on 7/25/17.
//  Copyright © 2017 Bruce32. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private let healthKitManager = HealthKitManager()
	private var nutritionController: NutritionViewController!
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		let navController = window!.rootViewController as! UINavigationController
		nutritionController = navController.viewControllers.first as! NutritionViewController
		
		nutritionController.healthKitManager = healthKitManager
		
		return true
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		
		nutritionController.refresh()
	}
}
