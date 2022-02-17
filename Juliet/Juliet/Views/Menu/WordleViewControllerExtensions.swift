//
//  WordleViewControllerExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/2/22.
//

import Foundation
import UIKit


protocol WordleViewControllerDelegate {
    func energyButtonPressed()
    
    func playEnergyButtonPressed()
    
    func playAdButtonPressed()
}


// Pause Unpause user interaction
extension WordleViewController {
    private func resumeUserInteractionAsSomethingFailed() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
        }
    }
    
    private func pauseUserInteractionAsPlayButtonIsPressed() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
        }
    }
}



extension WordleViewController: WordleViewControllerDelegate {
    
    
    private func presentGameAsRewardAfterAd() {
         
         pauseUserInteractionAsPlayButtonIsPressed()
         
         SecretWordModel.sharedInstance.generateNewWord { isFetchSuccesful in
             if isFetchSuccesful {
                 DispatchQueue.main.async {
                     let gameVC = GameViewController()
                     gameVC.navigationController?.isNavigationBarHidden = true
                     self.navigationController?.pushViewController(gameVC, animated: true)
                     self.resumeUserInteractionAsSomethingFailed()
                 }
             }
             else {
                 self.resumeUserInteractionAsSomethingFailed()
             }
         }
     }
    
    func playAdButtonPressed() {
        
        if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
                let reward = ad.adReward
                print("reward Amount: \(reward.amount)")
                self.presentGameAsRewardAfterAd()
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
    
    
    func playEnergyButtonPressed() {
        
        if Reachability.isConnectedToNetwork() {
            pauseUserInteractionAsPlayButtonIsPressed()
            UserSessionManager.sharedInstance.startNewGameSession { isGameSessionStarted in
                if isGameSessionStarted {
                    DispatchQueue.main.async {
                        let gameVC = GameViewController()
                        gameVC.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.pushViewController(gameVC, animated: true)
                    }
                }
                else {
                    self.resumeUserInteractionAsSomethingFailed()
                }
            }
        }
        
        return

    }

    
    func energyButtonPressed() {
        
    }
    

    
}
