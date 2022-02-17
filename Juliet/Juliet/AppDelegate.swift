//
//  AppDelegate.swift
//  Juliet
//
//  Created by Arteezy on 2/1/22.
//

import UIKit
import GoogleMobileAds
import StoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    /// Set Initial Energy To 30, otherwise, call server wins later 
    private func initializeUserEnergy() {
        
        let userEnergy = UserDefaults.standard.value(forKey: "userEnergy") as! Int?
        if userEnergy == nil {
            UserDefaults.standard.set(30, forKey: "userEnergy")
        }
        
        UserSessionManager.sharedInstance.fetchUserWins()
        
        return
    }
    
    private func initializeUserWins() {
        let userWins = UserDefaults.standard.value(forKey: "userWins") as! Int?
        
        if userWins == nil {
            UserDefaults.standard.set(0, forKey: "userWins")
        }
        return
    }
    
    /// By Default Show Ads, only if IAP is made than change the value
    private func initializeUserAdPreferances() {
        let blockBannerAds = UserDefaults.standard.value(forKey: "blockBannerAds") as? Bool
        let blockInterstitialAds = UserDefaults.standard.value(forKey: "blockInterstitialAds") as? Bool
        let blockAllAds = UserDefaults.standard.value(forKey: "blockAllAds") as? Bool
        
        if blockBannerAds == nil {
            UserDefaults.standard.set(false, forKey: "blockBannerAds")
        }
        
        if blockInterstitialAds == nil {
            UserDefaults.standard.set(false, forKey: "blockInterstitialAds")
        }
        
        if blockAllAds == nil {
            UserDefaults.standard.set(false, forKey: "blockAllAds")
        }
        
        return
    }
    
    private func initializeUserRegistration() {
        initializeUserEnergy()
        initializeUserAdPreferances()

        let launchCounter = UserDefaults.standard.integer(forKey: "launchCounter")
        
        if launchCounter == 0 {
            
            let authRequestManager = AuthenticationManager.authSharedInstance
            
            authRequestManager.firstAppLaunchUserRegistration(vendorID: getVendorIDForApp()) { isRequestSuccesful in
                print("Request Status: \(isRequestSuccesful)")
                if isRequestSuccesful == true {
                    UserDefaults.standard.set(launchCounter+1, forKey: "launchCounter")
                    UserDefaults.standard.set(self.getVendorIDForApp(), forKey: "userID")
                }
                else {
                    print("Something went wrong trying to register the user")
                }
            }
        }
        else {
            print("Already Synced")
        }
        
    }
    
    /// Get the vendor id for app when user launches the app for the first time
    /// - Returns: unique vendor id for user
    private func getVendorIDForApp() -> String {
        let uniqueVendorID = UIDevice.current.identifierForVendor!.uuidString
        print("uniqueVendorID: \(uniqueVendorID)")
        return uniqueVendorID
    }
    
    /// Initialize model of all the allowed words  Text conversion code from -> https://stackoverflow.com/a/24098109/14918173
    private func initializeAllowedWords() {
        
        let path = Bundle.main.path(forResource: "allowedWords", ofType: "txt") // file path for file "data.txt"
//      Read from file as an array
        let allowedWordsArray = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8).split(separator: "\n")
//      Conver to hash table
        let allowedWordsHashTable = Set(allowedWordsArray!)
        
//      initialise global model
        AllowedWordsModel.allAllowedWords = allowedWordsHashTable
        
    }
    
    
    /// Starts google admob 
    private func initializeGoogleAdMob() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    private func configureInAppPurchases() {
        SKPaymentQueue.default().add(StoreObserver.sharedInstance)
        IAPManager.sharedInstance.fetchProducts()
    }
    
//  Reason for choosing edge optimised API Gateway -> https://stackoverflow.com/a/49845124
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeGoogleAdMob()
        initializeUserWins()
        configureInAppPurchases()
        initializeAllowedWords()
        initializeUserRegistration()
        
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        SKPaymentQueue.default().remove(StoreObserver.sharedInstance)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

