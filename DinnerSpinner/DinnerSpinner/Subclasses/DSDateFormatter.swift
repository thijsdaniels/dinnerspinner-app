//
//  DSDateFormatter.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import Foundation
import UIKit

class DSDateFormatter: DateFormatter {
	
	override init() {
		super.init()
		
		self.timeZone = TimeZone.current
		self.locale = NSLocale.current
		self.dateFormat = "dd-MM-yyyy HH:mm"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
