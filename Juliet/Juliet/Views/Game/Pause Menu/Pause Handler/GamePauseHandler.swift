//
//  GamePauseHandler.swift
//  Juliet
//
//  Created by Arteezy on 2/3/22.
//

import Foundation
import UIKit



protocol GamePauseHandlerDelegate {
    func homeButtonPressedInPauseMenu()
    func restartWithEnergyButtonPressedInPauseMenu()
    func restartWithAdButtonPressedInPauseMenu()
    
}

class GamePauseHandler {
    
    var delegate: GamePauseHandlerDelegate?
    
    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    struct PauseMenuConstants{
        static let pauseMenuHeight: CGFloat = 350
    }
    
    let gamePauseViewController: GamePauseViewController = GamePauseViewController()
    
    var myTargetView: UIView?
    
    func showAlert(onViewController: UIViewController) {
        
        gamePauseViewController.delegate = self
        
        guard let targetView = onViewController.view else { return }
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.6
        }
        
        onViewController.addChild(gamePauseViewController)
        targetView.addSubview(gamePauseViewController.view)
        
        gamePauseViewController.view.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 30, height: PauseMenuConstants.pauseMenuHeight)
//        gamePauseViewController.view.layer.cornerRadius = 10
        
        UIView.animate(withDuration: 0.25) {
            self.gamePauseViewController.view.center = targetView.center
        }
    }
    
    
}
