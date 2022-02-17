//
//  ShopViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/10/22.
//


import UIKit
import SwiftUI
import GoogleMobileAds
import StoreKit

class ShopViewController: UIViewController {
    
    let shopSwiftUIView = UIHostingController(rootView: ShopSwiftUIView())
    
    var bannerView: GADBannerView?
    let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
    
    private func configureBannerAdView() {
        
        bannerView = GADBannerView(adSize: adSize)
        
        bannerView!.rootViewController = self
        bannerView!.adUnitID = GoogleAdMobAdUnitIDModel.julietShopBannerAd
        bannerView!.load(GADRequest())
        
        bannerView!.delegate = self
        
        bannerView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView!)
        
        NSLayoutConstraint.activate([
            bannerView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bannerView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView!.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func configureShopAccordingToAdStatus() {
        
        if AdManager.sharedInstance.blockBannerAds == true || AdManager.sharedInstance.blockAllAds == true {
            NSLayoutConstraint.activate([
                shopSwiftUIView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                shopSwiftUIView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                shopSwiftUIView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                shopSwiftUIView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                shopSwiftUIView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                shopSwiftUIView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                shopSwiftUIView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                shopSwiftUIView.view.bottomAnchor.constraint(equalTo: bannerView!.topAnchor)
            ])
        }
    }
    
    private func reloadPageToRemoveAds() {
        
        bannerView?.removeFromSuperview()
        
        
        NSLayoutConstraint.activate([
            shopSwiftUIView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shopSwiftUIView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shopSwiftUIView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shopSwiftUIView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.layoutIfNeeded()
        
    }
    
    

    private func configureShopSwiftUIView() {
        
        addChild(shopSwiftUIView)
        shopSwiftUIView.view.frame = view.frame
        shopSwiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shopSwiftUIView.view)
        
        configureShopAccordingToAdStatus()

    }
    
    @objc func restorePurchaseButtonPressed() {
        SKPaymentQueue.default().restoreCompletedTransactions()
        return
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        AdManager.sharedInstance.updateShopPageAdDisplay = reloadPageToRemoveAds
        
        title = "Shop"
        
        if AdManager.sharedInstance.blockBannerAds == false && AdManager.sharedInstance.blockAllAds == false {
            configureBannerAdView()
        }
        
        configureShopSwiftUIView()
        
        let energyStatus = UIBarButtonItem(customView: EnergyStatusView())
        navigationItem.rightBarButtonItem = energyStatus
        

        
        let restoreButton = UIBarButtonItem(title: "Restore", style: .plain,target: self, action: #selector(restorePurchaseButtonPressed))
        navigationItem.leftBarButtonItem = restoreButton
        
        view.backgroundColor = .white
//        view.backgroundColor = .customGreen
        
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
