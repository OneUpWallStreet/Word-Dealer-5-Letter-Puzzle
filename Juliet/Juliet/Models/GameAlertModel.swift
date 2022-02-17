//
//  GameAlertModel.swift
//  Juliet
//
//  Created by Arteezy on 2/5/22.
//

import Foundation
import UIKit

enum AlertType {
    case notInList
    case incompleteWord
}

struct AlertModelData {
    var width: CGFloat
    var text: String
}

struct GameAlertModel {
    
    static func getAlertModel(alertType: AlertType) -> AlertModelData  {
        switch alertType {
        case .notInList:
            return AlertModelData(width: 145.8, text: "Word not in list")
        case .incompleteWord:
            return AlertModelData(width: 177.2, text: "Complete the word")
        }
    }
    
}


