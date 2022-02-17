//
//  StartNewGameSessionResponse.swift
//  Juliet
//
//  Created by Arteezy on 2/15/22.
//

import Foundation
//
//{
//    "lambdaInvocationHttpsStatusCode": 200,
//    "body": {
//        "dynamoDBInvocationHttpsStatusCode": 200,
//        "userEnergy": 15.0,
//        "secretWord": [
//            "D",
//            "O",
//            "N",
//            "U",
//            "T"
//        ]
//    }
//}

struct StartNewGameSessionResponse: Codable {
    
    var lambdaInvocationHttpsStatusCode: Int
    
    struct NewGameSessionBody: Codable {
        var dynamoDBInvocationHttpsStatusCode: Int
        var userEnergy: Int
        var secretWord: Array<String>
    }
    
    var body: NewGameSessionBody
    
}
