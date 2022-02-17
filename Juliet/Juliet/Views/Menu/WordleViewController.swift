//
//  HomeViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/1/22.
//

import UIKit
import SwiftUI
import GoogleMobileAds

class WordleViewController: UIViewController {
    
    let wordleMainMenu = UIHostingController(rootView: WordleMainMenu())

    var bannerView: GADBannerView?

    let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 100))
    
    
    var rewardedAd: GADRewardedAd?
    
    

    private func configureBannerAdView() {
        
        bannerView = GADBannerView(adSize: adSize)
        
        bannerView!.rootViewController = self
        bannerView!.adUnitID = GoogleAdMobAdUnitIDModel.julietMainMenuBannerAd
        bannerView!.load(GADRequest())
                
        bannerView!.delegate =  self
        
        bannerView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView!)
        
        NSLayoutConstraint.activate([
            bannerView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bannerView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView!.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    
    /// Fetch Ad for the rewarded Play Button
    func fetchRewardedAd() {
        
        GADRewardedAd.load(withAdUnitID: GoogleAdMobAdUnitIDModel.julietPlayGameRewardedAd, request: GADRequest()) { ad, error in
            if let error = error {
                print("Something went wrong while loading rewarded ad error: \(error) and local desc: \(error.localizedDescription)")
            }
            print("rewarded ad fetched bro")
            
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
                
    }
    
    /// Remove Banner ad from menu, and reload the view
    private func reloadPageToRemoveAds() {
        
//      Remove Banner View being displayed
        bannerView?.removeFromSuperview()
        
        NSLayoutConstraint.activate([
            wordleMainMenu.view.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            wordleMainMenu.view.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            wordleMainMenu.view.topAnchor.constraint(equalTo: view.topAnchor),
            wordleMainMenu.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.layoutIfNeeded()
        
    }
    
    private func configureMainMenuConstraintsAccordingToAdStatus() {
        
        if AdManager.sharedInstance.blockBannerAds == true || AdManager.sharedInstance.blockAllAds == true {
            NSLayoutConstraint.activate([
                wordleMainMenu.view.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                wordleMainMenu.view.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                wordleMainMenu.view.topAnchor.constraint(equalTo: view.topAnchor),
                wordleMainMenu.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        else {
            NSLayoutConstraint.activate([
                wordleMainMenu.view.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                wordleMainMenu.view.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                wordleMainMenu.view.topAnchor.constraint(equalTo: view.topAnchor),
                wordleMainMenu.view.bottomAnchor.constraint(equalTo: bannerView!.topAnchor)
            ])
        }
        
    }
    
    private func configureMainMenu() {
        addChild(wordleMainMenu)
        wordleMainMenu.view.frame = view.frame
        wordleMainMenu.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordleMainMenu.view)
        
        configureMainMenuConstraintsAccordingToAdStatus()
        
//      Delegation from -> https://stackoverflow.com/questions/65076243/delegate-for-swiftui-view-from-hosting-view-controller
        wordleMainMenu.rootView.delegate = self
    
    }
    
//  Hide navigation controller from here to avoid the animation -> https://stackoverflow.com/a/47940946/14918173
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        view.isUserInteractionEnabled = true
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdManager.sharedInstance.updateHomePageAdDisplay = reloadPageToRemoveAds
        
        view.backgroundColor = .white
        fetchRewardedAd()
        
        if AdManager.sharedInstance.blockBannerAds == false && AdManager.sharedInstance.blockAllAds == false {
            configureBannerAdView()
        }
                
        configureMainMenu()
        // Do any additional setup after loading the view.
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
