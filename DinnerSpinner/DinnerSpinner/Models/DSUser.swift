//
//  DSUser.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSUser: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let userIDKey = "id"
		static let usernameKey = "username"
		
	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "userID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: userID)
		}
		set {
			userID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.userIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.userIDKey].int64,
			let _ = from[importableKeys.usernameKey].string
			
		{
			return true
			
		} else {
			
			print("Could not insert DSUser - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		userID = from[importableKeys.userIDKey].int64Value
		username = from[importableKeys.usernameKey].stringValue
		
	}
}
