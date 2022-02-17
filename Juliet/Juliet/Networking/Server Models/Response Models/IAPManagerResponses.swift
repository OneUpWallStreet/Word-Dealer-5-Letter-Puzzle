//
//  IAPManagerResponses.swift
//  Juliet
//
//  Created by Arteezy on 2/13/22.
//

import Foundation


struct EnergyUpdateResponse: Codable {
    
    struct DynamoDBResponseBody: Codable{
        let dynamoDBInvocationHttpsStatusCode: Int
        let userEnergy: Int
    }
    
    let lambdaInvocationHttpsStatusCode: Int
    let body: DynamoDBResponseBody
}

