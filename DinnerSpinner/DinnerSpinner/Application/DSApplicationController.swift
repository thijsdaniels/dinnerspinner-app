//
//  DSApplicationController.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import Foundation
import UIKit

class DSApplicationController {
	
	static let shared = DSApplicationController()

	func setupNavBar() {
		let navigationBarAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
		navigationBarAppearance.tintColor = .white
		navigationBarAppearance.barTintColor = UIColor.green
		navigationBarAppearance.isTranslucent = false
		navigationBarAppearance.backgroundColor = .white
		navigationBarAppearance.backItem?.backBarButtonItem?.tintColor = .white
		navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
		navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
	}
	
	
	
}
