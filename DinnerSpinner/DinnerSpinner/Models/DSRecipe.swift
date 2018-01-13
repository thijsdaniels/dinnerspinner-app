//
//  DSRecipe.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSRecipe: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let recipeIDKey = "id"
		static let nameKey = "name"
		static let ratingsKey = "rating"
		static let difficultyKey = "difficulty"
		static let servingsKey = "servings"
		static let prepartionDurationKey = "duration_preparation"
		static let cookingDurationKey = "duration_cooking"

		// Relationships
		static let imagesKey = "images"
		static let requirementsKey = "requirements"
		static let stepsKey = "steps"

	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "recipeID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: recipeID)
		}
		set {
			recipeID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.recipeIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.recipeIDKey].int64,
			let _ = from[importableKeys.nameKey].string,
			let _ = from[importableKeys.imagesKey].array,
			let _ = from[importableKeys.requirementsKey].array,
			let _ = from[importableKeys.stepsKey].array,
			let _ = from[importableKeys.servingsKey].int64
			
		{
			return true
			
		} else {
			
			print("Could not insert DSRecipe - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		recipeID = from[importableKeys.recipeIDKey].int64Value
		name = from[importableKeys.nameKey].stringValue
		servings = from[importableKeys.servingsKey].int64Value
		
		if let unwrappedPrepartionDuration = from[importableKeys.prepartionDurationKey].int64 {
			preparationDuration = unwrappedPrepartionDuration
		}
		
		if let unwrappedCookingDuration = from[importableKeys.cookingDurationKey].int64 {
			cookingDuration = unwrappedCookingDuration
		}
		
		if let unwrappedDifficulty = from[importableKeys.difficultyKey].float {
			difficulty = unwrappedDifficulty
		}

		if let requirementsArray = from[importableKeys.requirementsKey].array {
			
			let importedRequirements = try transaction.importUniqueObjects(Into<DSRequirement>(), sourceArray: requirementsArray)
			requirements = NSSet(array: importedRequirements)
		}
		
		if let imagesArray = from[importableKeys.imagesKey].array {
			
			let importedImages = try transaction.importUniqueObjects(Into<DSImage>(), sourceArray: imagesArray)
			images = NSSet(array: importedImages)
		}
		
		if let stepsArray = from[importableKeys.stepsKey].array {
			
			let importedSteps = try transaction.importUniqueObjects(Into<DSStep>(), sourceArray: stepsArray)
			requirements = NSSet(array: importedSteps)
		}
	}
}



