//
//  GameViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/2/22.
//

import UIKit
import SwiftUI
import GoogleMobileAds

class GameViewController: UIViewController {
    
    let wordleGame = UIHostingController(rootView: WordleGame())
    let gameAlertHandler = GameAlertHandler()
    let gamePauseHandler = GamePauseHandler()
    let gameOverHandler = GameOverHandler()
    
    var bannerView: GADBannerView?
    let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
    
    var interstitial: GADInterstitialAd?
    
    var rewardedAd: GADRewardedAd?
    
    func fetchRewardedAd() {
        
        GADRewardedAd.load(withAdUnitID: GoogleAdMobAdUnitIDModel.julietPlayGameRewardedAd, request: GADRequest()) { ad, error in
            
            if let error = error {
                print("something went wrong loading rewarded ad for pause menu \(error) and local: \(error.localizedDescription)")
            }
            
            print("rewarded ad fetched for pause menu")
            
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
        
    }
    
    
    /// Load Full screen Interstitial ad from google server
    private func loadInterstitialAdFromGoogle() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: GoogleAdMobAdUnitIDModel.julietGameInterstitialAd, request: request) { ad, error in
            if let error = error {
                print("Could not load ad, sorry \(error.localizedDescription) \(error)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
        }
    }

    
    func showFullScreenInterstitialAd() {
        
        if AdManager.sharedInstance.blockInterstitialAds == false && AdManager.sharedInstance.blockAllAds == false {
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
            }
            else {
                print("Ad not ready sorry, no money here lol")
                return
            }
        }
        else {
            print("user has blocked ads")
            return
        }
        

    }
    
    
    private func configureBannerADView() {
        
        bannerView = GADBannerView(adSize: adSize)
        
        bannerView!.rootViewController = self
        bannerView!.adUnitID = GoogleAdMobAdUnitIDModel.julietGameBannerAd
        bannerView!.load(GADRequest())
        
        bannerView!.delegate =  self
        
        bannerView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView!)
        
        NSLayoutConstraint.activate([
            bannerView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bannerView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView!.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func configureGameConstrainstsAccordingToAdStatus() {
        
        if AdManager.sharedInstance.blockBannerAds == true || AdManager.sharedInstance.blockAllAds == true {
            
            NSLayoutConstraint.activate([
                wordleGame.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                wordleGame.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                wordleGame.view.topAnchor.constraint(equalTo: view.topAnchor),
                wordleGame.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
        }
        else {
            NSLayoutConstraint.activate([
                wordleGame.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                wordleGame.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                wordleGame.view.topAnchor.constraint(equalTo: view.topAnchor),
                wordleGame.view.bottomAnchor.constraint(equalTo: bannerView!.topAnchor)
            ])
        }
        
    }
    
    private func reloadGameToRemoveAds() {
        
        bannerView?.removeFromSuperview()
        
        NSLayoutConstraint.activate([
            wordleGame.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wordleGame.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wordleGame.view.topAnchor.constraint(equalTo: view.topAnchor),
            wordleGame.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }
    
    private func configureWorldeGame() {
        
        addChild(wordleGame)
        
        wordleGame.view.frame = view.frame
        wordleGame.view.translatesAutoresizingMaskIntoConstraints = false
        
        setNeedsStatusBarAppearanceUpdate()
        
        wordleGame.rootView.delegate = self
        view.addSubview(wordleGame.view)
        
        configureGameConstrainstsAccordingToAdStatus()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
//  Hide navigation controller from here to avoid the animation -> https://stackoverflow.com/a/47940946/14918173
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = false
    }
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchRewardedAd()
        
        AdManager.sharedInstance.updateGamePageAdDisplay = reloadGameToRemoveAds
        
        self.tabBarController?.tabBar.isHidden = true
        
        if AdManager.sharedInstance.blockBannerAds == false && AdManager.sharedInstance.blockAllAds == false {
            configureBannerADView()
        }
        loadInterstitialAdFromGoogle()
        configureWorldeGame()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
