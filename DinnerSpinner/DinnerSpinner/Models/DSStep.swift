//
//  DSStep.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSStep: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let stepIDKey = "id"
		static let instructionKey = "instruction"
		static let positionKey = "position"

	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "stepID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: stepID)
		}
		set {
			stepID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.stepIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.stepIDKey].int64,
			let _ = from[importableKeys.instructionKey].string,
			let _ = from[importableKeys.positionKey].string

			
		{
			return true
			
		} else {
			
			print("Could not insert DSStep - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		stepID = from[importableKeys.stepIDKey].int64Value
		position = from[importableKeys.positionKey].int64Value
		instruction = from[importableKeys.instructionKey].stringValue
	}
}

