//
//  GamePauseViewControllerExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/4/22.
//

import Foundation




// This is for managing the GamePauseSwiftUI view
extension GamePauseViewController: GamePauseSwiftUIDelegate {
    
    func restartWithAdButtonPressedInSwiftUI() {
        delegate?.restartWithAdButtonPressed()
    }
    
    func homeButtonPressedInSwiftUI() {
        delegate?.homeButtonPressed()
    }
    
    func restartWithEnergyButtonPressedInSwiftUI() {
        delegate?.resumeButtonPressed()
        delegate?.restartWithEnergyButtonPressed()
    }
    
    /// Should go back to the back, this calls the GamePauseHandler 
    func resumeButtonPressedInSwiftUI() {
        delegate?.resumeButtonPressed()
    }
    
}
