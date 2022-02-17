//
//  CustomColors.swift
//  Juliet
//
//  Created by Arteezy on 2/2/22.
//

import Foundation
import UIKit
import SwiftUI


extension UIColor {
    static let customGreen = UIColor(named: "customGreen")!
    static let customBlue = UIColor(named: "customBlue")!
    static let customDark = UIColor(named: "customDark")!
    static let playBlue = UIColor(named: "playBlue")!
    static let sharkBlue = UIColor(named: "sharkBlue")!
    
    /// When the chosen alphabet is in correct location
    static let wordleGreen = UIColor(named: "wordleGreen")!
    
    /// When the chosen alphabet is there in word, but at diffrent location
    static let wordleYellow = UIColor(named: "wordleYellow")!
    
    /// Chosen Alphabet is wrong, not in word
    static let wordleGray = UIColor(named: "wordleGray")!
    
    /// Border For unsubmitted cell
    static let wordleBorderGray = UIColor(named: "wordleBorderGray")!
    
    /// Used For on-screen keyboard background color
    static let wordleIdleGray = UIColor(named: "wordleIdleAlphabet")!
    
    
    

}


extension Color {
    static let sharkBlue = Color("sharkBlue")
    static let customGreen = Color("customGreen")
    static let customBlue = Color("customBlue")
    static let customDark = Color("customDark")
    static let playBlue = Color("playBlue")
    static let wordleGreen = Color("wordleGreen")
    static let wordleGray = Color("wordleGray")
    static let wordleYellow = Color("wordleYellow")
    static let wordleBorderGray = Color("wordleBorderGray")
    static let wordleIdleGray = Color("wordleIdleAlphabet")

}
