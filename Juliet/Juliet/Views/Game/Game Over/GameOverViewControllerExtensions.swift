//
//  GameOverViewControllerExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/6/22.
//

import Foundation


extension GameOverViewController: GameOverSwiftUIDelegate {
    
    
    func homeButtonPressedInSwiftUIGameOver() {
        delegate?.homeButtonPressedInGameOver()
    }
    
    func restartButtonPressedInSwiftUIGameOver() {
//        delegate?.dismissGameOverMenu()
        delegate?.restartButtonPressedInGameOver()
    }
    
    
}
