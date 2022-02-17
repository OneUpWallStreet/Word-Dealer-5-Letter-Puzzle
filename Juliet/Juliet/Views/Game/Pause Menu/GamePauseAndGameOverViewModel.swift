//
//  GamePauseViewModel.swift
//  Juliet
//
//  Created by Arteezy on 2/13/22.
//

import Foundation

class GamePauseAndGameOverViewModel: ObservableObject {
    
    @Published var userEnergy: Int = UserSessionManager.sharedInstance.userEnergy
    
    func updateUserEnergyInPauseMenu() {
        DispatchQueue.main.async {
            self.userEnergy = UserSessionManager.sharedInstance.userEnergy
        }
        
    }
    
    /// If user has 0 energy show buy screen
    func promptUserToPurchaseEnergy() {
        let energyProduct = IAPManager.sharedInstance.getSelectedSKProductFromAvailableProducts(productIdentifier: IAPManager.JulietProducts.acquireEnergy.rawValue)
        if energyProduct != nil {
            IAPManager.sharedInstance.buySelectedProduct(energyProduct!)
        }
        return
    }
    
    func doesUserHaveEnergyToRestart() -> Bool {
        if userEnergy >= 5 {
            return true
        }
        else {
            return false
        }
    }
    
    init() {
        UserSessionManager.sharedInstance.updatePauseMenuEnergy = updateUserEnergyInPauseMenu
    }
}
