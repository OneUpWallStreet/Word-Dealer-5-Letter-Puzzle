//
//  SecretWordFetchModel.swift
//  Juliet
//
//  Created by Arteezy on 2/7/22.
//

import Foundation


struct SecretWordFetchModel: Codable {
    
    struct SecretWordResponseBody: Codable{
        let secretWord: Array<String>
    }
    
    let lambdaInvocationHttpsStatusCode: Int
    let body: SecretWordResponseBody
    
}
