//
//  DSAPIManager.swift
//  Spinbuzz
//
//  Created by George Coleman on 03/11/2016.
//  Copyright © 2016 PINCH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxAlamofire

class DSAPIManager {
	
	var configuration: URLSessionConfiguration
	var sessionManager: SessionManager
	
	var baseURL = "http://dinnerspinner.thijsdaniels.com"
	let api = "/api"
	let version = "/v1/"
	
	// create singleton
	static let shared = DSAPIManager()
	private init() {
		
		self.configuration = URLSessionConfiguration.default
		self.sessionManager = SessionManager(configuration: configuration)
	}
}

// MARK: Recipe calls
extension DSAPIManager {
	
	func getRecipes(with recipeID: Int? = nil) -> Observable<JSON> {
		
		var url = ""
		
		if let id = recipeID {
			url = self.baseURL + self.api + self.version + "recipes" + "\(id)"
		} else {
			url = self.baseURL + self.api + self.version + "recipes"
		}
		
		return self.sessionManager.rx.json(.get, url)
			.map { JSON($0) }
	}
	
	func getAllRecipesObservable() -> Observable<JSON> {
		return self.getRecipes()
	}
	
	func deleteRecipe(with recipeID: Int) -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "recipes" + "\(recipeID)"
		
		return self.sessionManager.rx.json(.delete, url)
			.map { JSON($0) }
	}
	
	func editRecipe(with recipeID: Int) -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "recipes" + "\(recipeID)"
		
		return self.sessionManager.rx.json(.put, url)
			.map { JSON($0) }
	}
	
	func addRecipe() -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "recipes"
		
		return self.sessionManager.rx.json(.post, url)
			.map { JSON($0) }
	}
}

// MARK: Requirements calls
extension DSAPIManager {
	
	func getRequirements(with requirementID: Int? = nil) -> Observable<JSON> {
		
		var url = ""
		
		if let id = requirementID {
			url = self.baseURL + self.api + self.version + "requirements" + "\(id)"
		} else {
			url = self.baseURL + self.api + self.version + "requirements"
		}
		
		return self.sessionManager.rx.json(.get, url)
			.map { JSON($0) }
	}
	
	func getAllRequirementsObservable() -> Observable<JSON> {
		return self.getRequirements()
	}
	
	func deleteRequirement(with requirementID: Int) -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "requirements" + "\(requirementID)"
		
		return self.sessionManager.rx.json(.delete, url)
			.map { JSON($0) }
	}
	
	func editRequirement(with requirementID: Int) -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "requirements" + "\(requirementID)"
		
		return self.sessionManager.rx.json(.put, url)
			.map { JSON($0) }
	}
	
	func addRequirement() -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "requirements"
		
		return self.sessionManager.rx.json(.post, url)
			.map { JSON($0) }
	}
}

// MARK: - Ingredient calls
extension DSAPIManager {
	func getAllIngredientsObservable() -> Observable<JSON> {
		
		let url = self.baseURL + self.api + self.version + "ingredients"
		
		return self.sessionManager.rx.json(.get, url)
			.map { JSON($0) }
	}
	
	func addIngredient() -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "ingredients"
		
		return self.sessionManager.rx.json(.post, url)
			.map { JSON($0) }
	}
}

// MARK: Colleague calls
extension DSAPIManager {
	
	func getUser(with userID: Int) -> Observable<JSON> {
		
		let url = self.baseURL + self.api + self.version + "users" + "\(userID)"
		
		return self.sessionManager.rx.json(.get, url)
			.map { JSON($0) }
	}
	
	func editUser(with userID: Int) -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "users" + "\(userID)"
		
		return self.sessionManager.rx.json(.put, url)
			.map { JSON($0) }
	}
	
	func addUser() -> Observable<JSON> {
		let url = self.baseURL + self.api + self.version + "users"
		
		return self.sessionManager.rx.json(.post, url)
			.map { JSON($0) }
	}
}
