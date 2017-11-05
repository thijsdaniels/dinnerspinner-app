//
//  DSStepsCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

class DSAddButtonCell: UITableViewCell {

    @IBOutlet weak var addIconButton: UIButton!
    @IBOutlet weak var addStepsButton: UIButton!
    var typeOfButton : EditRecipeCellType?
    
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
        if self.typeOfButton == EditRecipeCellType.Requirements {
            // Ingredients
            addStepsButton.setTitle("Voeg ingredient toe", for: .normal)
        } else {
            // Steps
            addStepsButton.setTitle("Voeg stap toe", for: .normal)
        }
    }
    
    @IBAction func addStepsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func addIconButtonPressed(_ sender: Any) {
        
    }
}
