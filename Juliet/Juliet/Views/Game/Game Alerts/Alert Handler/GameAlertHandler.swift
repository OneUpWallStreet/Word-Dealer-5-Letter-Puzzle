//
//  GameAlertHandler.swift
//  Juliet
//
//  Created by Arteezy on 2/5/22.
//

import Foundation
import UIKit

class GameAlertHandler {

    var gameAlertViewController: GameAlertViewController = GameAlertViewController()
    
    var myTargetView: UIView?
    var alertModelData: AlertModelData?
    
    
    func dismissAlert() {
        
        guard let targetView = myTargetView else {return}
        
        UIView.animate(withDuration: 0.25,animations: {
            self.gameAlertViewController.view.frame = CGRect(x: targetView.center.x, y: -300, width: self.alertModelData!.width, height: 50)
        }) { done in
            UIView.animate(withDuration: 0.25) {
            } completion: { done in
                self.gameAlertViewController.view.removeFromSuperview()
            }
        }
        
    }
    
    func showAlert(onViewController: UIViewController, alertModel :AlertModelData) {
        
        gameAlertViewController.alertText = alertModel.text
        
        alertModelData = alertModel
        
        guard let targetView = onViewController.view else { return }
        myTargetView = targetView
        onViewController.addChild(gameAlertViewController)
        targetView.addSubview(gameAlertViewController.view)
        
        gameAlertViewController.view.frame = CGRect(x: targetView.center.x, y: -300, width: alertModel.width, height: 50)
        
        UIView.animate(withDuration: 0.25) {
            self.gameAlertViewController.view.center = CGPoint(x: targetView.center.x, y: 200)
        }
        
    }
}
