//
//  DSNavigationController.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import Foundation
import UIKit

class DSNavigationController: UINavigationController {

	var type: Int? = nil

	/// Please use one of the following:
	// 0 for recipes
	// 1 for plan
	// 2 for list
	
	@IBInspectable var contentType: Int = -1 {
		didSet {
			if self.contentType > -1 && self.contentType <= 2 {
				self.type = self.contentType
			} else {
				assert(true, "The content type that was set in the Storyboard was not acceptable as a value. ")
			}
		}
	}
}
