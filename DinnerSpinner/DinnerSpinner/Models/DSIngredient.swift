//
//  DSIngredient.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSIngredient: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let ingredientIDKey = "id"
		static let nameKey = "name"
		
	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "ingredientID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: ingredientID)
		}
		set {
			ingredientID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.ingredientIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.ingredientIDKey].int64,
			let _ = from[importableKeys.nameKey].string
			
		{
			return true
			
		} else {
			
			print("Could not insert DSIngredient - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		ingredientID = from[importableKeys.ingredientIDKey].int64Value
		name = from[importableKeys.nameKey].stringValue
		
	}
}



