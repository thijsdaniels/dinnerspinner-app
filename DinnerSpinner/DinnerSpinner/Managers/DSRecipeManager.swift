//
//  DSRecipeManager.swift
//  DinnerSpinner
//
//  Created by George Coleman on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxAlamofire
import CoreStore

class DSRecipeManager {
	
	static let shared = DSRecipeManager()
	
	private init() {
	}
	
	func getRecipeObservable(for recipeID: Int?) -> Observable<DSRecipe?> {
		
		return DSAPIManager.shared.getRecipes(with: recipeID)
			.map { recipeJSON in
				
				var recipe: DSRecipe?
				
				try? CoreStore.perform(synchronous: { (transaction) in
					
					recipe = try! transaction.importUniqueObject(Into<DSRecipe>(), source: recipeJSON)
				})
				
				return recipe
		}
	}
	
	func getAllRecipesObservable() -> Observable<[DSRecipe]> {
		
		return DSAPIManager.shared.getAllRecipesObservable()
			.map { recipeJSON in
				
				let jsonArray = recipeJSON["recipes"].arrayValue
				
				var recipesArray: [DSRecipe] = []
				
				try? CoreStore.perform(synchronous: { (transaction) in
					recipesArray = try! transaction.importUniqueObjects(Into<DSRecipe>(), sourceArray: jsonArray)
					
					let predicate = NSPredicate(format: "NOT (SELF IN %@)", recipesArray)
					transaction.deleteAll(From<DSRecipe>(), Where<DSRecipe>(predicate))
					
				})
				
				
				return recipesArray
		}
	}
}

