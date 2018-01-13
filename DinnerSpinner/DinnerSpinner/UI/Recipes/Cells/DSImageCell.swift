//
//  DSImageCell.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit

protocol DSImageCellDelegate {
    func addImageButtonPressed(for imageCell: DSImageCell)
}

class DSImageCell: UITableViewCell {

    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var delegate: DSImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        
    }
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        self.delegate?.addImageButtonPressed(for: self)
    }
    
}
