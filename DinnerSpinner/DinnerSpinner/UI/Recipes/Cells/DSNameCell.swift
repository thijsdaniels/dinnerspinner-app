//
//  DSNameCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

class DSNameCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.placeholder = "recipes_name".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        
    }
    
}
