//
//  DSStepsCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

protocol DSAddButtonCellDelegate {
    func addButtonPressed(for addButtonCell: DSAddButtonCell)
}

class DSAddButtonCell: UITableViewCell {

    @IBOutlet weak var addIconButton: UIButton!
    @IBOutlet weak var addStepsButton: UIButton!
    var typeOfButton : EditRecipeCellType?
    
    var delegate: DSAddButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addIconButton.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        // Setup image and title
        if self.typeOfButton == .Requirements {
            // Ingredients
            addStepsButton.setTitle("recipes_add_ingredient".localized, for: .normal)
        } else {
            // Steps
            addStepsButton.setTitle("recipes_add_step".localized, for: .normal)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.delegate?.addButtonPressed(for: self)
    }
    
    @IBAction func addIconButtonPressed(_ sender: Any) {
        self.delegate?.addButtonPressed(for: self)
    }
}
