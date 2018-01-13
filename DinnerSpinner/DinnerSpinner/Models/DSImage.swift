//
//  DSImage.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import CoreStore
import SwiftyJSON

extension DSImage: ImportableUniqueObject {
	
	struct importableKeys {
		
		static let imageIDKey = "id"
		static let typeKey = "type"
		static let widthKey = "width"
		static let heightKey = "height"
		static let urlKey = "url"

		// Relationships
		static let formatsKey = "formats"
		
	}
	
	public typealias ImportSource = JSON
	public typealias UniqueIDType = NSNumber
	
	public static var uniqueIDKeyPath: String {
		return "imageID"
	}
	
	public var uniqueIDValue: UniqueIDType {
		get {
			return NSNumber(value: imageID)
		}
		set {
			imageID = uniqueIDValue.int64Value
		}
	}
	
	public static func shouldUpdate(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		return true
		
	}
	
	public static func uniqueID(from: ImportSource , in: BaseDataTransaction) throws -> UniqueIDType? {
		
		return from[importableKeys.imageIDKey].number
	}
	
	public static func shouldInsert(from: ImportSource, in: BaseDataTransaction) -> Bool {
		
		if let _ = from[importableKeys.imageIDKey].int64,
			let _ = from[importableKeys.typeKey].string,
			let _ = from[importableKeys.widthKey].int64,
			let _ = from[importableKeys.heightKey].int64,
			let _ = from[importableKeys.urlKey].string

		{
			return true
			
		} else {
			
			print("Could not insert DSImage - required properties not there!")
			return false
		}
	}
	
	public func update(from: ImportSource, in transaction: BaseDataTransaction) throws {
		
		imageID = from[importableKeys.imageIDKey].int64Value
		type = from[importableKeys.typeKey].stringValue
		width = from[importableKeys.widthKey].int64Value
		height = from[importableKeys.heightKey].int64Value
		url = from[importableKeys.urlKey].stringValue

		if let formatsArray = from[importableKeys.formatsKey].array {
			let importedFormats = try transaction.importUniqueObjects(Into<DSImage>(), sourceArray: formatsArray)
			images = NSSet(array: importedFormats)
		}
	}
}


