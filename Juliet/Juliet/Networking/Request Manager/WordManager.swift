//
//  WordManager.swift
//  Juliet
//
//  Created by Arteezy on 2/7/22.
//

import Foundation


class WordManager {
    
    static let wordSharedInstance = WordManager()
    private let generalRequestManager = GeneralRequestManager.sharedInstance
    
    /// Add the current word played to the list
    /// - Parameter playedWord: the current secret word
    func updateUserPlayedWordsList(playedWord: String) {
        
        let userID = UserDefaults.standard.value(forKey: "userID") as? String
        
        if userID == nil {
            return
        }
        
        generalRequestManager.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_WordManager, body: ["userID":userID!,"playedWord": playedWord,"requestType": "updateUserPlayedWordsList"]) { data in
            
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(DefaultServerResponse.self, from: data!) {
                    if decodedResponse.body.dynamoDBInvocationHttpsStatusCode == 200 {
                        print("Word added to list")
                    }
                    else {
                        print("Something went wrong while appending word to list")
                    }
                }
            }
            else {
                return
            }
            
        }
    }
    
    /// Gets a  5 letter word from Lambda in the form of an array
    /// - Parameter completion: returns a optional string array, if request is succesful word is nil and the default word is used i.e. drunk
    func fetchUniqueFiveLetterWord(completion: @escaping (Array<String>?) -> Void) {
        
        let userID = UserDefaults.standard.value(forKey: "userID") as? String
        
        if userID == nil {
            completion(nil)
        }
        
        
        generalRequestManager.generatePOSTServerRequest(url: AWSAPIGatewayURLs.Juliet_WordManager, body: ["userID":userID!,"requestType": "fetchNewSecretWord"]) { data in
            if data != nil {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(SecretWordFetchModel.self, from: data!){
                    print("word from server is: \(decodedResponse.body.secretWord)")
                    
                    completion(decodedResponse.body.secretWord)
                }
            }
            else {
                completion(nil)
            }
        }
    }
    
}
