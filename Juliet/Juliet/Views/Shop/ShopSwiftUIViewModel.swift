//
//  ShopSwiftUIViewModel.swift
//  Juliet
//
//  Created by Arteezy on 2/10/22.
//

import Foundation
import StoreKit

struct ProductDetailInfo: Identifiable{
    var id: UUID = UUID()
    var product: SKProduct
    var isBestSeller: Bool
}

class ShopSwiftUIViewModel: ObservableObject {
            
//  These cannot be empty they need to set to the values in shared IAPManager instance
    @Published var availableGameplayProducts: Array<ProductDetailInfo> = []
    @Published var availableAdProducts: Array<ProductDetailInfo> = []
    

    func updateProductsInShop() {
                
        for product in IAPManager.sharedInstance.availableProducts {
                        
            if product.productIdentifier == "Juliet.UIKit.Feb.One.2022.Juliet.removeAds" || product.productIdentifier == "Juliet.UIKit.Feb.One.2022.Juliet.removeBannerAds" || product.productIdentifier == "Juliet.UIKit.Feb.One.2022.Juliet.removeInterstitialAds" {
                var isBestSeller: Bool = false
                if product.productIdentifier == "Juliet.UIKit.Feb.One.2022.Juliet.removeAds" {
                    isBestSeller = true
                }
                
                DispatchQueue.main.async {
                    self.availableAdProducts.append(ProductDetailInfo(product: product, isBestSeller: isBestSeller))
                }
                

            }
            else {
                var isBestSeller: Bool = false
                if product.productIdentifier == "Juliet.UIKit.Feb.One.2022.Juliet.acquire30EnergyBundle" {
                    isBestSeller = true
                }
                DispatchQueue.main.async {
                    self.availableGameplayProducts.append(ProductDetailInfo(product: product, isBestSeller: isBestSeller))
                }
                
            }
        }
        print(availableGameplayProducts)
    }
    
    init() {
        updateProductsInShop()
        IAPManager.sharedInstance.updateProductsInShop = updateProductsInShop
        
    }
    

    
}
