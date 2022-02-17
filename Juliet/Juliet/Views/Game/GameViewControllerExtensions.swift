//
//  GameViewControllerExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/3/22.
//

import Foundation
import UIKit

protocol GameViewControllerDelegate {
    func showPauseMenu()
    func showGameAlert(alert: AlertModelData)
    func showGameOverMenu(didWin: Bool)
}

extension GameViewController: GamePauseHandlerDelegate {
    
    func restartWithAdButtonPressedInPauseMenu() {
        if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
                let reward = ad.adReward
                print("reward Amount: \(reward.amount)")
                print("Reward Earned")
                
                if Reachability.isConnectedToNetwork() {
                    SecretWordModel.sharedInstance.generateNewWord { isFetchSuccesful in
                        if isFetchSuccesful {
                            DispatchQueue.main.async {
                                self.gamePauseHandler.gamePauseViewController.delegate?.resumeButtonPressed()
                                self.wordleGame.rootView.wordleVM.restartGameSession()
                            }
                        }
                    }
                }
            }
        }
        else {
            let alert = UIAlertController(
              title: "Rewarded ad isn't available yet.",
              message: "The rewarded ad cannot be shown at this time",
              preferredStyle: .alert)
            let alertAction = UIAlertAction(
              title: "OK",
              style: .cancel,
              handler: { action in
                  print("okay")
              })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func restartWithEnergyButtonPressedInPauseMenu() {
        showFullScreenInterstitialAd()

        if Reachability.isConnectedToNetwork() {
            
            UserSessionManager.sharedInstance.startNewGameSession { isGameSessionStarted in
                if isGameSessionStarted {
                    DispatchQueue.main.async {
                        self.wordleGame.rootView.wordleVM.restartGameSession()
                    }
                }
            }
        }

    }
    
    
    func homeButtonPressedInPauseMenu() {
        showFullScreenInterstitialAd()
        self.navigationController?.popViewController(animated: true)
    }

}


extension GameViewController: GameOverHandlerDelegate {
    
    
    func restartButtonPressedInGameOver() {
//        showFullScreenInterstitialAd()
        if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
                let reward = ad.adReward
                print("reward Amount: \(reward.amount)")
                print("Reward Earned")
                
                if Reachability.isConnectedToNetwork() {
                    SecretWordModel.sharedInstance.generateNewWord { isFetchSuccesful in
                        if isFetchSuccesful {
                            DispatchQueue.main.async {
                                self.gameOverHandler.gameOverViewController.delegate?.dismissGameOverMenu()
//                                self.gamePauseHandler.gamePauseViewController.delegate?.resumeButtonPressed()
                                self.wordleGame.rootView.wordleVM.restartGameSession()
                            }
                        }
                    }
                }
            }
        }
        else {
            let alert = UIAlertController(
              title: "Rewarded ad isn't available yet.",
              message: "The rewarded ad cannot be shown at this time",
              preferredStyle: .alert)
            let alertAction = UIAlertAction(
              title: "OK",
              style: .cancel,
              handler: { action in
                  print("okay")
              })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func homeButtonPressedInGameOver() {
        showFullScreenInterstitialAd()
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension GameViewController: GameViewControllerDelegate {
    
    func showGameOverMenu(didWin: Bool) {
        
        let wordManager = WordManager.wordSharedInstance
        wordManager.updateUserPlayedWordsList(playedWord: SecretWordModel.sharedInstance.secretWordString.lowercased())
        
        
        gameOverHandler.delegate = self
        gameOverHandler.showGameOverView(onViewController: self, secretWord: SecretWordModel.sharedInstance.secretWordString, didWin: didWin)
        
    }
    
    func showGameAlert(alert: AlertModelData) {
        
        gameAlertHandler.showAlert(onViewController: self, alertModel: alert)
        
//      Delay code from -> https://stackoverflow.com/a/32696605
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gameAlertHandler.dismissAlert()
        }
    }
    
    func showPauseMenu() {
  
//        This is the main pause menu function change later
        gamePauseHandler.delegate = self
        gamePauseHandler.showAlert(onViewController: self)
        
        print("I miss u")

    }
    
}
