//
//  UIColor.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	
	static func from(hex: String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}
		
		if ((cString.count) != 6) {
			assert(true, "This is not a valid hex")
		}
		
		var rgbValue:UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
	func darken() -> UIColor{
		
		// init some adjust values
		var adjustValueR: CGFloat = 0
		var adjustValueG: CGFloat = 0
		var adjustValueB: CGFloat = 0
		var adjustValueA: CGFloat = 0
		
		// get the red green and blue
		self.getRed(&adjustValueR, green: &adjustValueG, blue: &adjustValueB, alpha: &adjustValueA)
		
		// return color
		return UIColor(red: adjustValueR - 0.2, green: adjustValueG - 0.2, blue: adjustValueB - 0.2, alpha: adjustValueA)
	}
}
