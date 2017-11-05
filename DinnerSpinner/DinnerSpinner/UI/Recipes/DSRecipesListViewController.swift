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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func addBarButtonItemPressed(_ sender: UIBarButtonItem) {
		self.performSegue(withIdentifier: "addRecipeSegue", sender: nil)
	}
}
