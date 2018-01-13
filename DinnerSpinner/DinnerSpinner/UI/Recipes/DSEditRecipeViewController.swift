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

class DSEditRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DSBulletCellDelegate, DSAddButtonCellDelegate, DSImageCellDelegate, UIPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var editRecipeArr = [[String: Any]]()
    var requirementsArr = [String]()
    var stepsArr = [String]()
    
    var dsBulletCell: DSBulletCell?
    var dsImageCell: DSImageCell?
    
    fileprivate var picker: UIPicker?
    let imagePicker = UIImagePickerController()
    
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
        
        // Setup possible choices for UIPicker
        picker = UIPicker(parentViewController: self)
        picker?.delegate = self
        picker?.set(items: ["1", "2", "3"])
        
        imagePicker.delegate = self
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
                cell.delegate = self
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
                    cell.typeOfButton = .Requirements
                    cell.titleField.placeholder = "recipes_ingredient".localized
                    cell.quantityField.placeholder = "recipes_amount".localized
                    cell.quantityField.isHidden = false
                    cell.unitButton.isHidden = false
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSAddButtonCell", for: indexPath) as? DSAddButtonCell {
                    cell.typeOfButton = .Requirements
                    cell.setupCell()
                    cell.delegate = self
                    return cell
                }
            }
        } else if (editRecipeArr[indexPath.section]["type"] as? String == "steps") {
            if indexPath.row < self.stepsArr.count {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSBulletCell", for: indexPath) as? DSBulletCell {
                    cell.setupCell(title: self.stepsArr[indexPath.row])
                    cell.delegate = self
                    cell.typeOfButton = .Steps
                    cell.titleField.placeholder = "recipes_step".localized
                    cell.quantityField.isHidden = true
                    cell.unitButton.isHidden = true
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DSAddButtonCell", for: indexPath) as? DSAddButtonCell {
                    cell.typeOfButton = .Steps
                    cell.setupCell()
                    cell.delegate = self
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
    
    func deleteButtonPressed(for bulletCell: DSBulletCell) {
        // Delete row
        if let indexPath = self.tableview.indexPath(for: bulletCell) {
            if bulletCell.typeOfButton == .Steps {
                // delete in steps
                stepsArr.remove(at: indexPath.row)
            } else {
                // delete in requirements
                requirementsArr.remove(at: indexPath.row)
            }
            self.tableview.deleteRows(at: [indexPath], with: .automatic)
        }
        print("delete button pressed")
    }
    
    func unitButtonPressed(for bulletCell: DSBulletCell) {
        self.dsBulletCell = bulletCell
        picker?.startPicking()
    }
    
    // MARK - DSAddButtonCellDelegate
    
    func addButtonPressed(for addButtonCell: DSAddButtonCell) {
        // Add row
        if addButtonCell.typeOfButton == .Requirements {
            // Add new ingredient
            self.requirementsArr.append("")
        } else {
            // Add new step
            self.stepsArr.append("")
        }
        
        self.tableview.reloadData()
    }
    
    // MARK - DSImageCellDelegate
    
    func addImageButtonPressed(for imageCell: DSImageCell) {
        // Open image picker
        self.dsImageCell = imageCell
        imagePicker.allowsEditing = false
        //imagePicker.sourceType = [.photoLibrary, .camera]
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK - UIPickerDelegate
    
    @objc func pickerCancelAction() {
        picker?.endPicking()
    }
    
    @objc func pickerSetAction() {
        if let selectedItem = picker?.selectedItem {
            dsBulletCell?.unitButton.setTitle(selectedItem, for: .normal)
        }
        picker?.endPicking()
    }
    
    func pickerView(inputAccessoryViewFor pickerView: UIPicker) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        view.backgroundColor = .white
        let buttonWidth: CGFloat = 100
        
        let cancelButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - buttonWidth - 10, y: 0, width: buttonWidth, height: 30))
        cancelButton.setTitle("button_cancel".localized, for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitleColor(.lightGray, for: .highlighted)
        cancelButton.addTarget(self, action: #selector(pickerCancelAction), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        let setButton = UIButton(frame: CGRect(x: 10, y: 0, width: buttonWidth, height: 30))
        setButton.setTitle("button_ok".localized, for: .normal)
        setButton.setTitleColor(.black, for: .normal)
        setButton.setTitleColor(.lightGray, for: .highlighted)
        setButton.addTarget(self, action: #selector(pickerSetAction), for: .touchUpInside)
        view.addSubview(setButton)
        
        return view
    }
    
    func pickerView(didSelect value: String, inRow row: Int, delegatedFrom pickerView: UIPicker) {
        print("\(value)")
    }
    
    // MARK - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dsImageCell?.addImageButton.backgroundColor = UIColor.clear
            dsImageCell?.addImageButton.setTitle("", for: .normal)
            dsImageCell?.recipeImageView.contentMode = .scaleToFill
            dsImageCell?.recipeImageView.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}
