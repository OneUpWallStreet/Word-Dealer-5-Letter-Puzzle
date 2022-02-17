//
//  GameOverHandlerExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/6/22.
//

import Foundation
import UIKit

extension GameOverHandler: GameOverViewControllerDelegate {
    
    func dismissGameOverMenu() {
        guard let targetView = myTagertView else {return}
        UIView.animate(withDuration: 0.25,animations: {
            self.gameOverViewController.view.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-30, height: GameOverConstants.gameOverHeight)
        }) { done in
            UIView.animate(withDuration: 0.25) {
                self.backgroundView.alpha = 0
            } completion: { done in
                self.gameOverViewController.view.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
            }
        }
    }
    
    
    func homeButtonPressedInGameOver() {
        delegate?.homeButtonPressedInGameOver()
    }
    
    func restartButtonPressedInGameOver() {
        delegate?.restartButtonPressedInGameOver()
    }
    
    
}
