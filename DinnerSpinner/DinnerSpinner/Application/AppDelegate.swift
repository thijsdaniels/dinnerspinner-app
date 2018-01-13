//
//  AppDelegate.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
		DSApplicationController.shared.setupNavBar()
		UIApplication.shared.statusBarStyle = .lightContent
		
		// Initialize the DataStack for CoreStore
		self.initializeDatastackForCorestore()

		return true
	}
}

extension AppDelegate {
	
	func initializeDatastackForCorestore() {
		let dataStack = DataStack()
		
		let storage = SQLiteStore(fileName: "Data.sqllite",
								  localStorageOptions: [.recreateStoreOnModelMismatch, .allowSynchronousLightweightMigration])
		
		do {
			try dataStack.addStorageAndWait(storage)
		} catch let error {
			print("Error occured with corestore:  \(error)")
		}
		
		CoreStore.defaultStack = dataStack
		
	}
}

