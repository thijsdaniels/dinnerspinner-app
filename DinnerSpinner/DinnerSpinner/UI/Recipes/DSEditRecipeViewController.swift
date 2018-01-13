//
//  DSEditRecipeViewController.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

enum EditRecipeCellType {
    case Image
    case Name
    case Requirements
    case Steps
    case Duration
}

class DSEditRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DSBulletCellDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var editRecipeArr = [[String: Any]]()
    var requirementsArr = [String]()
    var stepsArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: "DSNameCell", bundle: nil), forCellReuseIdentifier: "DSNameCell")
        tableview.register(UINib(nibName: "DSImageCell", bundle: nil), forCellReuseIdentifier: "DSImageCell")
        tableview.register(UINib(nibName: "DSBulletCell", bundle: nil), forCellReuseIdentifier: "DSBulletCell")
        tableview.register(UINib(nibName: "DSAddButtonCell", bundle: nil), forCellReuseIdentifier: "DSAddButtonCell")
        tableview.register(UINib(nibName: "DSDurationCell", bundle: nil), forCellReuseIdentifier: "DSDurationCell")
        
        // Structure of sections - type and height
        editRecipeArr = [["type" : "image", "height" : 175.0], ["type" : "name", "height" : 70.0], ["type" : "requirements", "height" : 60.0], ["type" : "steps", "height" : 60.0], ["type" : "duration", "height" : 70.0]]
        
        // For now, some dummy requirements and steps.
        requirementsArr = ["100 gram bloem", "500 gram boter", "1 komkommer"]
        stepsArr = ["Doe de pasta in de pan", "Kook de pasta", "Haal de pasta uit de pan"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (editRecipeArr[section]["type"] as? String == "requirements") {
            return requirementsArr.count + 1
        } else if (editRecipeArr[section]["type"] as? String == "steps") {
            return stepsArr.count + 1
        }
        
        // In all the other cases, return 1
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = editRecipeArr[indexPath.section]["height"] as? Double {
            return CGFloat(height)
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (editRecipeArr[indexPath.section]["type"] as? String == "image") {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DSImageCell", for: indexPath) as? DSImageCell {
                cell.setupCell()
                return cell
            }
        } else if (editRecipeArr[indexPath.section]["type"] as? String == "name") {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DSNameCell", for: indexPath) as? DSNameCell {
                cell.setupCell()
                return cell
            }
        } else if (editRecipeArr[indexPath.section]["type"] as? String == "requirements") {
            if indexPath.row < self.requirementsArr.count {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSBulletCell", for: indexPath) as? DSBulletCell {
                    cell.setupCell(title: requirementsArr[indexPath.row])
                    cell.delegate = self
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSAddButtonCell", for: indexPath) as? DSAddButtonCell {
                    cell.typeOfButton = EditRecipeCellType.Requirements
                    cell.setupCell()
                    return cell
                }
            }
        } else if (editRecipeArr[indexPath.section]["type"] as? String == "steps") {
            if indexPath.row < self.stepsArr.count {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSBulletCell", for: indexPath) as? DSBulletCell {
                    cell.setupCell(title: self.stepsArr[indexPath.row])
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSAddButtonCell", for: indexPath) as? DSAddButtonCell {
                    cell.typeOfButton = EditRecipeCellType.Steps
                    cell.setupCell()
                    return cell
                }
            }
        } else if (editRecipeArr[indexPath.section]["type"] as? String == "duration") {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DSDurationCell", for: indexPath) as? DSDurationCell {
                cell.setupCell()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return editRecipeArr.count
    }
    
    // MARK - DSBulletCellDelegate
    
    func deleteButtonPressed(_ sender: Any) {
        // Delete row
        print("delete button pressed")
    }
    
    
}
