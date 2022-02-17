//
//  ArrayExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/4/22.
//

import Foundation


extension Array where Element == String {
    
    func convertArrayToString() -> String {
        
        var str: String = ""
        
        for alphabet in self {
            str.append(alphabet)
        }
        
        return str
    }
    
    func removeFirstInstanceOfString(_ givenString: String) -> Array<String> {
        var newArr: Array<String> = []
        var isFirstElementFound: Bool = false
        
        for item in self {
            if givenString != item {
                newArr.append(item)
            }
            if givenString == item {
                if isFirstElementFound == false {
                    isFirstElementFound = true
                    continue
                }
                else {
                    newArr.append(item)
                }
            }
        }
        return newArr
    }
    
}
