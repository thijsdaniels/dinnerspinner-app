//
//  DSRequirementsCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

protocol DSBulletCellDelegate {
    func deleteButtonPressed(for bulletCell: DSBulletCell)
    func unitButtonPressed(for bulletCell: DSBulletCell)
}

class DSBulletCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var bulletView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var unitButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: DSBulletCellDelegate?
    var typeOfButton : EditRecipeCellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        deleteButton.imageView?.contentMode = .scaleAspectFit
        quantityField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String) {
        self.titleField.text = title
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.delegate?.deleteButtonPressed(for: self)
    }
    
    @IBAction func unitButtonPressed(_ sender: Any) {
        self.delegate?.unitButtonPressed(for: self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
