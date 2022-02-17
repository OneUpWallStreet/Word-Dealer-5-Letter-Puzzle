//
//  UserSessionManager.swift
//  Juliet
//
//  Created by Arteezy on 2/11/22.
//

import Foundation


class UserSessionManager {
        
    static let sharedInstance = UserSessionManager()
    
    
    /// Starts a new games, reduces user energy by 5 and fetches new word
    /// - Parameter completion: if request was succesful
    func startNewGameSession(completion: @escaping (Bool) -> Void) {
        
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else {
            completion(false)
            return
        }
        
        guard let currentEnergy = UserDefaults.standard.value(forKey: "userEnergy") as? Int else {
            completion(false)
            return
        }
        
        if currentEnergy == 0 {
            print("user's energy is 0, he/she is not allowed to play")
            completion(false)
            return
        }
        
        GeneralRequestManager.sharedInstance.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_UserSessionManager, body: ["userID": userID,"requestType": "statNewGameSession"]) { data in
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(StartNewGameSessionResponse.self, from: data!){
                    print("decodedResponse: \(decodedResponse)")
                    
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        UserDefaults.standard.set(decodedResponse.body.userEnergy, forKey: "userEnergy")
                        self.updateInstanceEnergyFromUserDefaults()
                                                
                        SecretWordModel.sharedInstance.secretWord = decodedResponse.body.secretWord
                        
                        completion(true)
                        return
                    }
                    else {
                        completion(false)
                        return
                    }
                    
                }
            }
            else {
                completion(false)
                return
            }
        }
    }
    
    

    func handleUserEnergyPurchase(purchaseType: String,completion: @escaping (Bool) -> Void) {
        
        
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else {
            completion(false)
            return
        }
        var body: [String: Any]?
        
        //Single Energy Bought that is a 5 pack
        if purchaseType == IAPManager.JulietProducts.acquireEnergy.rawValue {
            body = ["userID":userID,"requestType": "handleEnergyPurchase", "energyPurchaseAmount": 5]
        }
        else if purchaseType == IAPManager.JulietProducts.acquire30EnergyBundle.rawValue {
            body = ["userID":userID,"requestType": "handleEnergyPurchase", "energyPurchaseAmount": 30]
        }
        else {
            print("Only 5 or 30 bundles are avaiable rn")
            completion(false)
            return
        }
        
        GeneralRequestManager.sharedInstance.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_IAPManager, body: body!) { data in
            
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(EnergyUpdateResponse.self, from: data!){
                    print(decodedResponse.body.dynamoDBInvocationHttpsStatusCode)
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        UserDefaults.standard.set(decodedResponse.body.userEnergy, forKey: "userEnergy")
                        self.updateInstanceEnergyFromUserDefaults()
                        completion(true)
                        return
                    }
                    else {
                        print("status code for purchase is not 200, i.e. 404 failed")
                        completion(false)
                        return
                    }
                }
                else {
                    print("Decode failed")
                    completion(false)
                    return
                }
            }
            else {
                print("data is nil in energy purchase handler")
                completion(false)
                return
            }
            
        }
        
        
    }
    
    /// Reduces energy by 5, when the user presses play button
    /// - Parameter completion: Returns boolean value, indiciation wheather user can procced to play or not.
    func singleGameEnergyUpdate(completion: @escaping (Bool) -> Void) {
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        let currentEnergy = UserDefaults.standard.value(forKey: "userEnergy") as! Int

//      If user energy is 0, dont bother going forward
        if currentEnergy == 0 {
            print("Current energy is 0, user not allowed to play")
            completion(false)
            return
        }
        
        GeneralRequestManager.sharedInstance.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_IAPManager, body: ["userID": userID,"requestType": "singleGameEnergyUpdate"]) { data in
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(EnergyUpdateResponse.self, from: data!) {
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        print("Status code 200")
                        UserDefaults.standard.set(decodedResponse.body.userEnergy, forKey: "userEnergy")
                        self.updateInstanceEnergyFromUserDefaults()
                        completion(true)
                        return
                    }
                    else {
                        print("Failed")
                        completion(false)
                        return
                    }
                }
            }
            else {
                print("Major Fail")
                completion(false)
                return
            }
        }
    }
    
    
    
    /// Call this when you make a change in userEnergy userdefaults value
    func updateInstanceEnergyFromUserDefaults() {
        userEnergy = UserDefaults.standard.value(forKey: "userEnergy") as! Int
    }
    
    /// Call this when you changes user wins (userdefaults) value
    func updateUserWinsFromUserDefaults() {
        userWins = UserDefaults.standard.value(forKey: "userWins") as! Int
    }
    
    
    /// Update user wins on server, increments the win by 1. This is called from Wordle View Model please change the logic there later
    func updateUserWins() {
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        print("UPDATE USER WINS SHOULD BE CALLED NOW")
        
        GeneralRequestManager.sharedInstance.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_UserSessionManager, body: ["userID" : userID, "requestType": "updateUserWins"]) { data in
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(UserWinsResponse.self, from: data!) {
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        UserDefaults.standard.set(decodedResponse.body.userWins, forKey: "userWins")
                        self.updateUserWinsFromUserDefaults()
                    }
                }
            }
        }
        
    }

    
    /// Fetches the wins for user and should update MainMenu
    func fetchUserWins() {
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        GeneralRequestManager.sharedInstance.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_UserSessionManager, body: ["userID": userID,"requestType": "fetchUserWins"]) { data in
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(UserWinsResponse.self, from: data!){
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        self.userWins = decodedResponse.body.userWins
                    }
                }
            }
        }
        
    }
    
    var userWins = UserDefaults.standard.value(forKey: "userWins") as! Int  {
        didSet {
            updateMainMenuUserWins?()
        }
    }
    
    var userEnergy = UserDefaults.standard.value(forKey: "userEnergy") as! Int {
        didSet{
//          UI Updates in Shop,MainMenu and Pause Menu
            updateHomePageEnergy?()
            updateShopEnergyInNavigationBar?()
            updatePauseMenuEnergy?()
        }
    }
    var updateMainMenuUserWins: (() -> Void)?
    
    var updatePauseMenuEnergy: (() -> Void)?
    var updateHomePageEnergy: (() -> Void)?
    var updateShopEnergyInNavigationBar: (() -> Void)?
    
    

    
    
    
}
