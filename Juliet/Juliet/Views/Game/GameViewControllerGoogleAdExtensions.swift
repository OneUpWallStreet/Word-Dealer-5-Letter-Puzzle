//
//  GameViewControllerGoogleAdExtensions.swift
//  Juliet
//
//  Created by Arteezy on 2/9/22.
//

import Foundation
import GoogleMobileAds


extension GameViewController: GADBannerViewDelegate {
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("Error for banner ad in game: \(error) and \(error.localizedDescription)")
    }
    
}

extension GameViewController: GADFullScreenContentDelegate {
    
    
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    
//      Fetch new ad, as soon as the old ad is dismissed -> https://developers.google.com/admob/ios/rewarded
            GADRewardedAd.load(withAdUnitID: GoogleAdMobAdUnitIDModel.julietPlayGameRewardedAd, request: GADRequest()) { ad, error in
                if let error = error {
                    print("Something went wrong while loading rewarded for pause menu ad error: \(error) and local desc: \(error.localizedDescription)")
                }
                    
                self.rewardedAd = ad
                self.rewardedAd?.fullScreenContentDelegate = self
            }
        
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Either intersitial or full screen rewarded ad presented")
    }
    
}


