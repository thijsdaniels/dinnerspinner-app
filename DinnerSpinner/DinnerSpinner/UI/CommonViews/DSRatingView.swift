//
//  DSRatingView.swift
//  DinnerSpinner
//
//  Created by George Coleman on 04/11/2017.
//  Copyright © 2017 Digithio. All rights reserved.
//

import UIKit
import Cosmos

class DSRatingView: CosmosView {

    private let startRating: Double = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.settings.fillMode = .half
        self.didTouchCosmos = didTouchCosmos
        self.didFinishTouchingCosmos = didFinishTouchingCosmos
        
        // Set colors
        self.settings.emptyColor = UIColor.white
        self.settings.emptyBorderColor = Colors.pumpkinOrange()
        self.settings.filledBorderColor = Colors.pumpkinOrange()
        self.settings.filledColor = Colors.pumpkinOrange()
        
        // Update rating
        updateRating()
    }
    
    private func updateRating() {
        // Check if rating is available. If not, start with startRating.
        self.rating = startRating
    }
    
    private func didTouchCosmos(_ rating: Double) {
        
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        
    }

}
