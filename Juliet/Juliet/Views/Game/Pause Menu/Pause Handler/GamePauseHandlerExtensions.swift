//
//  GamePauseHandlerExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/4/22.
//

import Foundation
import UIKit




extension GamePauseHandler: GamePauseViewControllerDelegate {
    
    func restartWithAdButtonPressed() {
        delegate?.restartWithAdButtonPressedInPauseMenu()
    }
    
    
    func restartWithEnergyButtonPressed() {
        delegate?.restartWithEnergyButtonPressedInPauseMenu()
    }
    
    func homeButtonPressed() {
        delegate?.homeButtonPressedInPauseMenu()
    }
    
    func resumeButtonPressed() {
        
        guard let targetView = myTargetView else {return}
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25,animations: {
                
                self.gamePauseViewController.view.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-30, height: PauseMenuConstants.pauseMenuHeight)
            }) { done in
                UIView.animate(withDuration: 0.25) {
                    self.backgroundView.alpha = 0
                } completion: { done in
                    self.gamePauseViewController.view.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                }
            }
        }

    }
}
