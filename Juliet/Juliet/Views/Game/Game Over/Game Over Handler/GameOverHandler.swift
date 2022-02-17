//
//  GameOverHandler.swift
//  Juliet
//
//  Created by Arteezy on 2/6/22.
//

import Foundation
import UIKit

protocol GameOverHandlerDelegate {
    func homeButtonPressedInGameOver()
    func restartButtonPressedInGameOver()
}

class GameOverHandler {
    
    struct GameOverConstants {
        static let gameOverHeight: CGFloat = 300
    }
    
    var gameOverViewController: GameOverViewController = GameOverViewController()
    var myTagertView: UIView?
    
    var delegate: GameOverHandlerDelegate?
    
    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    func showGameOverView(onViewController: UIViewController,secretWord: String, didWin: Bool) {
        
        print("didWin in handler: \(didWin)")
        
        gameOverViewController.delegate = self
        gameOverViewController.secretWord = secretWord
        gameOverViewController.didWin = didWin
        
        guard let targetView = onViewController.view else {return}
        
        myTagertView = targetView
        
        backgroundView.frame = targetView.bounds
        
        targetView.addSubview(backgroundView)
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.6
        }
        
        onViewController.addChild(gameOverViewController)
        targetView.addSubview(gameOverViewController.view)
        
        gameOverViewController.view.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-30, height: GameOverConstants.gameOverHeight)
     
        UIView.animate(withDuration: 0.25) {
            self.gameOverViewController.view.center = targetView.center
        }
    }
    
}
