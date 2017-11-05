//
//  DSTabBarController.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

	@objc enum DSNavControllerType: Int {
		case Recipes = 0
		case Plan = 1
		case ShoppingList = 2
	}
	
	class DSTabBarController: UITabBarController, UITabBarControllerDelegate {
		
		var index: Int = -1
		
		required init?(coder aDecoder: NSCoder) {
			super.init(coder: aDecoder)
		}
		
		override func viewDidLoad() {
			super.viewDidLoad()
			
			self.loadLayout()
			self.delegate = self
		}
		
		func loadLayout() {
			self.tabBar.isTranslucent = false
			self.tabBar.barTintColor = UIColor.from(hex: "D35400")
			
			self.insertImagesForTabBarItems()
			self.removeTitleForTabBarItems()
		}
	
		func removeTitleForTabBarItems() {
			if let items = self.tabBar.items {
				for item in items {
					item.title = nil
					item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
				}
			}
		}
		
		func insertImagesForTabBarItems() {
			
			let tabColor = UIColor.from(hex: "FCF4D0")

			if let vcs = self.viewControllers {
				for viewController in vcs {
					if let navController = viewController as? DSNavigationController {
						
						switch (navController.contentType) {
						case DSNavControllerType.Recipes.rawValue:
							navController.tabBarItem.image = UIImage(named: "TabBarRecipesIcon")?.withRenderingMode(.alwaysOriginal).withCustomTint(tintColor: tabColor)
							navController.tabBarItem.selectedImage = UIImage(named: "TabBarRecipesIcon")?.withRenderingMode(.alwaysOriginal).withCustomTint(tintColor: tabColor.darken())
						
						case DSNavControllerType.Plan.rawValue:
							navController.tabBarItem.image = UIImage(named: "TabBarPlanIcon")?.withRenderingMode(.alwaysOriginal).withCustomTint(tintColor: tabColor)
							navController.tabBarItem.selectedImage = UIImage(named: "TabBarPlanIcon")?.withRenderingMode(.alwaysOriginal).withCustomTint(tintColor: tabColor.darken())
							
						case DSNavControllerType.ShoppingList.rawValue:
							navController.tabBarItem.image = UIImage(named: "TabBarShoppingIcon")?.withRenderingMode(.alwaysOriginal).withCustomTint(tintColor: tabColor)
							navController.tabBarItem.selectedImage = UIImage(named: "TabBarShoppingIcon")?.withRenderingMode(.alwaysOriginal).withCustomTint(tintColor: tabColor.darken())
							
						default: return
						}
					} else {
						assert(true, "The controller in the tab bar is not a DSNavController class")
					}
				}
			}
		}
	}

