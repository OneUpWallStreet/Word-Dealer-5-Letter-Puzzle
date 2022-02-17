//
//  WordleGameViewModel.swift
//  Juliet
//
//  Created by Arteezy on 2/4/22.
//

import Foundation
import SwiftUI

/// Gray, Yellow, Green show details about the chosen word, edit means that row is still being edited by the user
enum WordleColor {
    case gray
    case yellow
    case green
    case edit
    
    static func getCellColor(_ status: WordleColor) -> Color {
        
        switch status {
        case .gray:
            return Color.wordleGray
        case .yellow:
            return Color.wordleYellow
        case .green:
            return Color.wordleGreen
//      Should never be in .edit, can ignore this case, returning garbage value
        case .edit:
//          Random Value
            return Color.black
        }
    }
}

struct AlphabetStatus {
    var alphabet: String
    var status: WordleColor
}

struct KeyboardColor {
    let backgroundColorOfKeyboard: Color
    let foregroundColorOfKeyboard: Color
}

enum GameStatusForManagingDelegate {
    case alert
    case gameoverLoss
    case gameoverWin
    case ignore
}

class WordleGameViewModel: ObservableObject {
    
    @Published var guessedWords: Array<Array<String>> = [["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""]]

    @Published var guessedWordsStatus: Array<Array<WordleColor>> = [[.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                    [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                    [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit]]
    
    @Published var keyboardColors: Array<KeyboardColor> = Array<KeyboardColor>(repeating: KeyboardColor(backgroundColorOfKeyboard: .wordleIdleGray, foregroundColorOfKeyboard: .black), count: Alphabets.allAlphabets.count)
    
    
    @Published var usedAlphabets: Array<AlphabetStatus> = []
    
        
    var secretWord: Array<String> = SecretWordModel.sharedInstance.secretWord
 
    @Published var currentRow = 0
    @Published var currentIndex = 0
    @Published var isSpaceFullInCurrentRow: Bool = false
    
    /// Restarts the game chaning the secret word, and removing all the local data about the current gameplay status
    func restartGameSession() {
        let secretWordManager = SecretWordModel.sharedInstance
        secretWordManager.generateNewWord { wordChangeStatus in
            if wordChangeStatus {
                DispatchQueue.main.async {
                    self.guessedWords = [["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""]]
                    self.guessedWordsStatus = [[.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                                [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                                [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit]]
                    self.keyboardColors = Array<KeyboardColor>(repeating: KeyboardColor(backgroundColorOfKeyboard: .wordleIdleGray, foregroundColorOfKeyboard: .black), count: Alphabets.allAlphabets.count)
                    self.usedAlphabets = []
                    self.isSpaceFullInCurrentRow = false
                    self.currentIndex = 0
                    self.currentRow = 0
                    self.secretWord = secretWordManager.secretWord
                }
            }
        }
    }
    
    func checkSingleRow() {
        let guessedWord: Array<String> = guessedWords[currentRow]
        var availableAlphabets: Array<String> = secretWord

        for (index,alphabet) in guessedWord.enumerated() {
            if secretWord.contains(alphabet) && guessedWord[index] == secretWord[index]  {
                guessedWordsStatus[currentRow][index] = .green
                keyboardColors[Alphabets.getIndexOfAlphabet(alphabet)] = KeyboardColor(backgroundColorOfKeyboard: .wordleGreen, foregroundColorOfKeyboard: .white)
                availableAlphabets = availableAlphabets.removeFirstInstanceOfString(alphabet)
            }
            
        }
        
        for (index,alphabet) in guessedWord.enumerated() {
            
            if secretWord.contains(alphabet) == false {
                guessedWordsStatus[currentRow][index] = .gray
                keyboardColors[Alphabets.getIndexOfAlphabet(alphabet)] = KeyboardColor(backgroundColorOfKeyboard: .wordleGray, foregroundColorOfKeyboard: .white)

            }
            
            else if secretWord.contains(alphabet) && guessedWord[index] != secretWord[index] && availableAlphabets.contains(alphabet) {
                guessedWordsStatus[currentRow][index] = .yellow
                keyboardColors[Alphabets.getIndexOfAlphabet(alphabet)] = KeyboardColor(backgroundColorOfKeyboard: .wordleYellow, foregroundColorOfKeyboard: .white)
                availableAlphabets = availableAlphabets.removeFirstInstanceOfString(alphabet)
            }
            
            else if secretWord.contains(alphabet) && guessedWord[index] != secretWord[index] && availableAlphabets.contains(alphabet) == false {
                guessedWordsStatus[currentRow][index] = .gray
            }
            
        }
        
    }

    
    func isWordIsAllowed() -> Bool {
        return AllowedWordsModel.checkIfWordIsAllowed(word: guessedWords[currentRow])
    }
    
    func handleWinCountUpdate() {
        UserSessionManager.sharedInstance.updateUserWins()
    }
    
    
    /// Enter/Submit button is pressed on the on screen keyboard
    func enterButtonIsPressed() -> (GameStatusForManagingDelegate,AlertType?){
        print("Word: \(SecretWordModel.sharedInstance.secretWordString)")
//      Go To Next Row, or the game is over
        if currentIndex == 4 && isSpaceFullInCurrentRow == true {
            
            if isWordIsAllowed() == true {
                checkSingleRow()
//              Do this is you check row 1 through 4
                if currentRow != 5 {
                    
//                  Check if user won
                    if guessedWords[currentRow].convertArrayToString() == SecretWordModel.sharedInstance.secretWordString {
//                      Please remove this logic later but for now update user wins is called from this lol
                        self.handleWinCountUpdate()
                        return (.gameoverWin,nil)
                    }
                    
                    currentRow += 1
                    currentIndex = 0
                    isSpaceFullInCurrentRow = false
                    
                    return (.ignore,nil)
                }
//              Do this if you just checked the last row and now game is over
                else {
                    if guessedWords[currentRow].convertArrayToString() == SecretWordModel.sharedInstance.secretWordString {
//                      Please remove this logic later but for now update user wins is called from this lol
                        self.handleWinCountUpdate()
                        return (.gameoverWin,nil)
                    }
                    else {
                        return (.gameoverLoss,nil)
                    }
                }
            }
            else {
                return (.alert,.notInList)
            }
        }
        else {
            return (.alert,.incompleteWord)
        }
    }
    
    /// Backspace button is pressed on the on screen keyboard
    func backspaceButtonIsPressed() {
        
        isSpaceFullInCurrentRow = false
        if guessedWords[currentRow][currentIndex] != "" {
            guessedWords[currentRow][currentIndex] = ""
        }
        else {
            if currentIndex != 0 {
                currentIndex -= 1
                guessedWords[currentRow][currentIndex] = ""

            }
        }
    }
    
    /// A button on the on-screen keyboard is pressed
    /// - Parameter alphabet: letter between -> A To Z
    func alphabetIsSelected(_ alphabet: String) {
        
        if self.isSpaceFullInCurrentRow == true {
            return
        }
        
        self.guessedWords[self.currentRow][self.currentIndex] = alphabet
        
        if self.currentIndex == 4 {
            self.isSpaceFullInCurrentRow = true
        }
        else {
            self.currentIndex += 1
        }
    }
    
}
