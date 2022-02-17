//
//  IAPManager.swift
//  Juliet
//
//  Created by Arteezy on 2/9/22.
//

import Foundation
import StoreKit


//This extension i got from -> https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/offering_completing_and_restoring_in-app_purchases
extension SKProduct {
    /// - returns: The cost of the product formatted in the local currency.
    var regularPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}


extension IAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        
        // products contains products whose identifiers have been recognized by the App Store. As such, they can be purchased.
        if !response.products.isEmpty {
            availableProducts = response.products
            print("Count: \(availableProducts.count)")
        }

        // invalidProductIdentifiers contains all product identifiers not recognized by the App Store.
        if !response.invalidProductIdentifiers.isEmpty {
            print("invalidProductIdentifiers description: \(response.invalidProductIdentifiers.description)")
        }
    }
    
}


class IAPManager: NSObject {
    
    enum JulietProducts: String,CaseIterable {
        case removeAds = "Juliet.UIKit.Feb.One.2022.Juliet.removeAds"
        case acquireEnergy = "Juliet.UIKit.Feb.One.2022.Juliet.acquireEnergy"
        case removeBannerAds = "Juliet.UIKit.Feb.One.2022.Juliet.removeBannerAds"
        case removeInterstitialAds = "Juliet.UIKit.Feb.One.2022.Juliet.removeInterstitialAds"
        case acquire30EnergyBundle = "Juliet.UIKit.Feb.One.2022.Juliet.acquire30EnergyBundle"
    }
    
    static let sharedInstance = IAPManager()
    
    var productRequest: SKProductsRequest?
    
//  Great stackoverflow answer about singletons!!! -> https://stackoverflow.com/a/30634664/14918173
    
    /// This is to update the UI in shop
    var updateProductsInShop: (() -> Void)?

    var availableProducts: Array<SKProduct> = [] {
        didSet {
            updateProductsInShop?()
        }
    }
    
    func getSelectedSKProductFromAvailableProducts(productIdentifier: String) -> SKProduct? {
        return availableProducts.first { $0.productIdentifier == productIdentifier }
    }
    
    func buySelectedProduct(_ product: SKProduct) {
        
        guard SKPaymentQueue.canMakePayments() else  {
            print("User cant make payments")
            return
        }
        
        print("You want to buy product: \(product.localizedDescription) and title: \(product.localizedTitle)")
        
        let paymentRequest = SKPayment(product: product)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    /// Initial fetch of products from app store, use this in appDidFinishLaunching
    func fetchProducts() {
        
        let julietProductIdentifiers = Set(JulietProducts.allCases.compactMap({$0.rawValue}))
        
        productRequest = SKProductsRequest(productIdentifiers: julietProductIdentifiers)
        productRequest?.delegate = self
        productRequest?.start()
        
//        SKPaymentQueue.tra
        
        
        

    }
    
}
