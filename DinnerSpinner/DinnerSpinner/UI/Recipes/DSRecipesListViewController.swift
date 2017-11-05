//
//  DSRecipesListViewController.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

class DSRecipesListViewController: UIViewController {

	@IBOutlet weak var addBarButtonItem: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.registerNibs()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func addBarButtonItemPressed(_ sender: UIBarButtonItem) {
		self.performSegue(withIdentifier: "addRecipeSegue", sender: nil)
	}
	
	func registerNibs() {
		let nib = UINib(nibName: "DSRecipeTableViewCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: "RecipeTableViewCell")
	}
}

extension DSRecipesListViewController: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell") as! DSRecipeTableViewCell
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 130
	}
}
