//
//  WordleViewControllerAdMobExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/11/22.
//

import Foundation
import GoogleMobileAds



extension WordleViewController: GADBannerViewDelegate {
        
    

    
}

extension WordleViewController: GADFullScreenContentDelegate {
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//      Fetch new ad, as soon as the old ad is dismissed -> https://developers.google.com/admob/ios/rewarded
        GADRewardedAd.load(withAdUnitID: GoogleAdMobAdUnitIDModel.julietPlayGameRewardedAd, request: GADRequest()) { ad, error in
            if let error = error {
                print("Something went wrong while loading rewarded ad error: \(error) and local desc: \(error.localizedDescription)")
            }
                
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("To PResent fail: \(error) and local \(error.localizedDescription)")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Rewarded ad presented.")
    }
    
}

