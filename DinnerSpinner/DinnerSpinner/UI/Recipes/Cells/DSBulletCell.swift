//
//  DSRequirementsCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

protocol DSBulletCellDelegate {
    func deleteButtonPressed(_ sender: Any)
    func unitButtonPressed(for bulletCell: DSBulletCell)
}

class DSBulletCell: UITableViewCell {
    
    @IBOutlet weak var bulletView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var unitButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: DSBulletCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        deleteButton.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String) {
        self.titleField.text = title
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.delegate?.deleteButtonPressed(sender)
    }
    
    @IBAction func unitButtonPressed(_ sender: Any) {
        self.delegate?.unitButtonPressed(for: self)
    }
    
}
