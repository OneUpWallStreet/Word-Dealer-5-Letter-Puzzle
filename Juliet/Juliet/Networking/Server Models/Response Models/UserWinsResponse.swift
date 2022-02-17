//
//  FetchUserWinsResponse.swift
//  Juliet
//
//  Created by Arteezy on 2/14/22.
//

import Foundation
//{
//   "lambdaInvocationHttpsStatusCode": 200,
//        "body": {
//            "userWins": 1.0
//        }
// }


struct UserWinsResponse: Codable {
    
    struct UserWinsBody: Codable {
        var userWins: Int
        var dynamoDBInvocationHttpsStatusCode: Int
    }
    
    var lambdaInvocationHttpsStatusCode: Int
    var body: UserWinsBody
    
}
