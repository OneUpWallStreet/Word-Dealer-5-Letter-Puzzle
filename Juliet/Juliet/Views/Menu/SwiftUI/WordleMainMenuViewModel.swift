//
//  WordleMainMenuViewModel.swift
//  Juliet
//
//  Created by Arteezy on 2/11/22.
//

import Foundation

class WordleMainMenuViewModel: ObservableObject {
    
    @Published var userEnergy = UserSessionManager.sharedInstance.userEnergy
    @Published var userWins = UserSessionManager.sharedInstance.userWins
    
    private func updateUserEnergyInMenu() {
        DispatchQueue.main.async {
            self.userEnergy = UserSessionManager.sharedInstance.userEnergy
        }
    }
    
    private func updateUserWinsInMenu() {
        DispatchQueue.main.async {
            self.userWins = UserSessionManager.sharedInstance.userWins
        }
    }
    
    
    
    init() {
        UserSessionManager.sharedInstance.updateHomePageEnergy = updateUserEnergyInMenu
        UserSessionManager.sharedInstance.updateMainMenuUserWins = updateUserWinsInMenu
    }
    
}
