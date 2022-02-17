//
//  AdManager.swift
//  Juliet
//
//  Created by Arteezy on 2/12/22.
//

import Foundation


class AdManager {
    
    static let sharedInstance: AdManager = AdManager()
    
    
    func handleUserRestorePurchase(restoreType: String,completion: @escaping (Bool) -> Void) {
        
        if restoreType == IAPManager.JulietProducts.removeAds.rawValue {
            UserDefaults.standard.set(true, forKey: "blockAllAds")
            updateAdStatusFromUserDefaults()
            completion(true)
            return
        }
//      Remove Banner Ads
        else if restoreType == IAPManager.JulietProducts.removeBannerAds.rawValue  {
            UserDefaults.standard.set(true, forKey: "blockBannerAds")
            updateAdStatusFromUserDefaults()
            completion(true)
            return
        }
        
//      Remove Interstitial Ad
        else if restoreType == IAPManager.JulietProducts.removeInterstitialAds.rawValue  {
            UserDefaults.standard.set(true, forKey: "blockInterstitialAds")
            updateAdStatusFromUserDefaults()
            completion(true)
            return
        }
        
        else {
            completion(false)
            return
        }

    }
    
    
    func handleUserAdBlockPurchase(purchaseType: String, completion: @escaping (Bool) -> Void) {
        
//      Remove All Ads
        if purchaseType == IAPManager.JulietProducts.removeAds.rawValue {
            UserDefaults.standard.set(true, forKey: "blockAllAds")
            updateAdStatusFromUserDefaults()
            completion(true)
            return
        }
        
//      Remove Banner Ads
        else if purchaseType == IAPManager.JulietProducts.removeBannerAds.rawValue  {
            UserDefaults.standard.set(true, forKey: "blockBannerAds")
            updateAdStatusFromUserDefaults()
            completion(true)
            return
        }
        
//      Remove Interstitial Ad
        else if purchaseType == IAPManager.JulietProducts.removeInterstitialAds.rawValue  {
            UserDefaults.standard.set(true, forKey: "blockInterstitialAds")
            updateAdStatusFromUserDefaults()
            completion(true)
            return
        }
        
        else {
            completion(false)
            return
        }        
        
    }
    
    /// Use this when you make change to userdefaults
    private func updateAdStatusFromUserDefaults() {
        blockBannerAds = UserDefaults.standard.value(forKey: "blockBannerAds") as! Bool
        blockAllAds = UserDefaults.standard.value(forKey: "blockAllAds") as! Bool
        blockInterstitialAds = UserDefaults.standard.value(forKey: "blockInterstitialAds") as! Bool
    }
    
    
    private func updateAllAdStatusInViews() {
        updateHomePageAdDisplay?()
        updateGamePageAdDisplay?()
        updateShopPageAdDisplay?()
    }
    
    var blockBannerAds: Bool = UserDefaults.standard.value(forKey: "blockBannerAds") as! Bool {
        didSet {
            if blockBannerAds == true {
                updateAllAdStatusInViews()
            }
        }
    }
    
    var blockAllAds: Bool = UserDefaults.standard.value(forKey: "blockAllAds") as! Bool {
        didSet {
            if blockAllAds == true {
                updateAllAdStatusInViews()
            }
        }
    }
    
    
    var blockInterstitialAds: Bool = UserDefaults.standard.value(forKey: "blockInterstitialAds") as! Bool

    
    var updateHomePageAdDisplay: (() -> Void)?
    var updateGamePageAdDisplay: (() -> Void)?
    var updateShopPageAdDisplay: (() -> Void)?
    
}
