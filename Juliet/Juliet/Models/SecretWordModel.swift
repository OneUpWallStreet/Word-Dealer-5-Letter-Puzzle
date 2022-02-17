//
//  SecretWordModel.swift
//  Juliet
//
//  Created by Arteezy on 2/7/22.
//

import Foundation


class SecretWordModel {
    
    static let sharedInstance = SecretWordModel()
    
//  This is just the default value
    var secretWord: Array<String> = ["D","R","U","N","K"] {
        didSet {
            secretWordString = secretWord.convertArrayToString()
            print("Secret word String: \(secretWordString)")
        }
    }
    
    
    var secretWordString: String = "drunk"
    
    /// Changes the secret word for the user when he presses play
    /// - Parameter completion: returns weather changing word was succesful
    func generateNewWord(completion: @escaping (Bool) -> Void) {
        let wordManager = WordManager.wordSharedInstance
        wordManager.fetchUniqueFiveLetterWord { newSecretWord in
            
            if newSecretWord == nil {
                completion(false)
                return
            }
            self.secretWord = newSecretWord!
            completion(true)
        }
    }
    
}
