//
//  DSSelection.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSSelection: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let selectionIDKey = "id"
		static let createdAtKey = "created_at"
		static let cookedAtKey = "cooked_at"
		static let canceledAtKey = "canceled_at"
		
		// Relationships
		static let recipeKey = "recipe"
		
	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "selectionID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: selectionID)
		}
		set {
			selectionID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.selectionIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.selectionIDKey].int64,
			let _ = from[importableKeys.recipeKey].dictionary,
			let _ = from[importableKeys.createdAtKey].int64
			
		{
			return true
			
		} else {
			
			print("Could not insert DSSelection - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		selectionID = from[importableKeys.selectionIDKey].int64Value
		
		if let unwrappedCreatedAtTimeStamp = from[importableKeys.createdAtKey].int64 {
			
			let unwrappedCreatedAtDate = Date(timeIntervalSince1970: TimeInterval(unwrappedCreatedAtTimeStamp))
			createdAt = unwrappedCreatedAtDate
		}
		
		if let unwrappedCookedAtTimeStamp = from[importableKeys.cookedAtKey].int64 {
			
			let unwrappedCookedAtDate = Date(timeIntervalSince1970: TimeInterval(unwrappedCookedAtTimeStamp))
			cookedAt = unwrappedCookedAtDate
		}
		
		if let unwrappedCanceledAtTimeStamp = from[importableKeys.canceledAtKey].int64 {
			
			let unwrappedCanceledAtDate = Date(timeIntervalSince1970: TimeInterval(unwrappedCanceledAtTimeStamp))
			canceledAt = unwrappedCanceledAtDate
		}
		
		let importedRecipe = try transaction.importUniqueObject(Into<DSRecipe>(), source: from[importableKeys.recipeKey])
		recipe = importedRecipe
		
	}
}

