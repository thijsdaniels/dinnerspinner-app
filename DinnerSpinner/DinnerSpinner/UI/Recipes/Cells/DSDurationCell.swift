//
//  DSDurationCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

class DSDurationCell: UITableViewCell {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textField.placeholder = "recipes_duration".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        
    }
    
    @IBAction func segmentedControlSwitched(_ sender: Any) {
        
    }
}
