//
//  AuthenticationManager.swift
//  Juliet
//
//  Created by Arteezy on 2/7/22.
//

import Foundation


/// The place for managing all the user registration & account creation process
class AuthenticationManager {
    
    static let authSharedInstance = AuthenticationManager()
    
    /// Register User when the app is launched for the first time
    /// - Parameters:
    ///   - vendorID: Unique identifier of the phone
    ///   - completion: was registration succesful?
    func firstAppLaunchUserRegistration(vendorID: String,completion: @escaping (Bool) -> Void) {
        
        let generalRequestManager = GeneralRequestManager.sharedInstance
        
        generalRequestManager.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_AuthenticateUser, body: ["vendorID": vendorID,"requestType": "initialRegistration"]) { data in
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(DefaultServerResponse.self, from: data!){
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
            else {
                completion(false)
            }
        }
    }
    
}
