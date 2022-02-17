//
//  DictionaryHandler.swift
//  Juliet
//
//  Created by Arteezy on 2/14/22.
//


//
//import Foundation
//
//struct DictionaryModel {
//    var phonetic: String?
//    var audioURL: String?
//    var definition: String?
//}
//
//class DictionaryManager {
//
//    static let sharedInstance: DictionaryManager = DictionaryManager()
//
//    let dictionaryAPIURL: String = "https://api.dictionaryapi.dev/api/v2/entries/en/"
//
//    var dictionaryModel = DictionaryModel()
//
//    func fetchDefinitionOfWord(_ word: String) {
//
//
////      Init model everyime this func is model
//
//        dictionaryModel = DictionaryModel()
//
//        print("IN MODEL!!")
//
//        let url = dictionaryAPIURL + word
//
//        GeneralRequestManager.sharedInstance.generateGETRequest(url: url) { data in
//
//            if data != nil {
//
//            print("data is not nil")
//
//            guard let responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) else {
//                print("guard let failed")
//                return
//            }
//
//
//            if let dictionary = responseJson as? Array<[String: Any]> {
//
//                print("dic is \(dictionary)")
//
//                if let phonetic = dictionary[0]["phonetic"] as? String {
//                    self.dictionaryModel.phonetic = phonetic
//                }
//
//                if let phoneticsDictionary = dictionary[0]["phonetics"] as? [String:String] {
//                    self.dictionaryModel.audioURL = phoneticsDictionary["audio"]
//                }
//
//                if let meaningsDictionary = dictionary[0]["meanings"] as? Array<[String: Any]> {
//
//                    if meaningsDictionary.count > 0 {
//
//                        if let definitionsDictionary = meaningsDictionary[0]["definitions"] as? Array<[String: Any]> {
//
//                            if definitionsDictionary.count > 0 {
//
//                                self.dictionaryModel.definition = definitionsDictionary[0]["definition"] as? String
//
//                                print("DICTIONARY MODEL READY \(self.dictionaryModel)")
//
//                            }
//
//                        }
//
//                    }
//
//                }
//
//            }
//                else {
//                    print("Okaty?")
//                }
//
//            }
//            else {
//                print("data is nil from dictionary api")
//            }
//
//        }
//
//    }
//
//}
