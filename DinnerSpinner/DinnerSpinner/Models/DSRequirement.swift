//
//  DSRequirement.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSRequirement: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let requirementIDKey = "id"
		static let quantityKey = "quantity"
		static let unitKey = "unit"
		static let boughtAtKey = "bought_at"
		
		// Relationships
		static let ingredientKey = "ingredient"
		
	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "requirementID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: requirementID)
		}
		set {
			requirementID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.requirementIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.requirementIDKey].int64,
			let _ = from[importableKeys.ingredientKey].array
			
		{
			return true
			
		} else {
			
			print("Could not insert DSRequirement - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		requirementID = from[importableKeys.requirementIDKey].int64Value
		
		if let unwrappedQuantity = from[importableKeys.quantityKey].float {
			quantity = unwrappedQuantity
		}
		
		if let unwrappedUnit = from[importableKeys.unitKey].string {
			unit = unwrappedUnit
		}
		
		if let unwrappedBoughtAtTimeStamp = from[importableKeys.boughtAtKey].int64 {
			
			let unwrappedBoughtAtDate = Date(timeIntervalSince1970: TimeInterval(unwrappedBoughtAtTimeStamp))
			boughtAt = unwrappedBoughtAtDate
		}
		
		let importedIngredient = try transaction.importUniqueObject(Into<DSIngredient>(), source: from[importableKeys.ingredientKey])
		ingredient = importedIngredient
		
	}
}




