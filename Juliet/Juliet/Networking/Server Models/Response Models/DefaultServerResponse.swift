//
//  UserAuthenticationResponse.swift
//  Juliet
//
//  Created by Arteezy on 2/7/22.
//

import Foundation


struct DefaultServerResponse: Codable {
    
    struct DynamoDBResponseBody: Codable{
        let dynamoDBInvocationHttpsStatusCode: Int
    }
    
    let lambdaInvocationHttpsStatusCode: Int
    let body: DynamoDBResponseBody
}


