//
//  UIImage.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
	
	func withCustomTint(tintColor: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		let context: CGContext = UIGraphicsGetCurrentContext()!
		
		context.translateBy(x: 0, y: self.size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		context.setBlendMode(CGBlendMode.normal)
		let rect: CGRect = CGRect(x:0, y:0, width:self.size.width, height:self.size.height)
		
		context.clip(to: rect, mask: self.cgImage!)
		
		tintColor.setFill()
		context.fill(rect)
		
		var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		newImage = newImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		return newImage
	}
	
}
