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
		navigationBarAppearance.barTintColor = UIColor.from(hex: "D35400")
		navigationBarAppearance.isTranslucent = false
		navigationBarAppearance.backItem?.backBarButtonItem?.tintColor = UIColor.from(hex: "FCF4D0")
		navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
		navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.from(hex: "FCF4D0")]
	}
	
	
	
}
