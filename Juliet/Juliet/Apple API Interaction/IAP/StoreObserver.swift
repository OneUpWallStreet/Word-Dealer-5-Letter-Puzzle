//
//  StoreObserver.swift
//  Juliet
//
//  Created by Arteezy on 2/9/22.
//

import Foundation
import StoreKit

class StoreObserver: NSObject, SKPaymentTransactionObserver {
        
    static var sharedInstance: StoreObserver = StoreObserver()
    
    private func handleFailedTransaction(_ transaction: SKPaymentTransaction) {
//      Ignore if user cancelled payment, otherwise check if there is network error and display alert
        if (transaction.error as? SKError)?.code != .paymentCancelled {
            if let transcationErrorType = (transaction.error as? SKError)?.code  {
                print("Error Type: \(transcationErrorType)")
            }

        }
        else {
            print("PAYMENT CANCELLED!!, closing transaction")
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }
    
    private func handlePurchase(_ transaction: SKPaymentTransaction){
        
        let singlePayment = transaction.payment
        
//      If current payment is in regards to energy purchase
        if singlePayment.productIdentifier == IAPManager.JulietProducts.acquireEnergy.rawValue || singlePayment.productIdentifier == IAPManager.JulietProducts.acquire30EnergyBundle.rawValue {
            
            UserSessionManager.sharedInstance.handleUserEnergyPurchase(purchaseType: singlePayment.productIdentifier) { isPurchaseSuccesful in
                
                if isPurchaseSuccesful == true {
                    print("Succesfully bought energy closing transcation")
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("Transaction closed")
                    return
                }
                else {
                    print("Something went wrong trying to purchase energy")
                    return
                }
            }
        }
//      If the current purchase is related to an AD
        else {
            
            AdManager.sharedInstance.handleUserAdBlockPurchase(purchaseType: singlePayment.productIdentifier) { isPurchaseSuccesful in
                
                if isPurchaseSuccesful {
                    print("Ads Should be removed now for \(singlePayment.productIdentifier)")
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("Transaction closed for ad")
                    return
                }
                else {
                    print("Something went wrong while trying to remove Ads")
                    return
                }
                
            }
        }
        
    }
    
    /// Issues a restore of non consumable product user has already bought
    /// - Parameter transaction: only ads can be restored currently as they are only non consumable offered
    private func handleRestore(_ transaction: SKPaymentTransaction){
        
        print("You are restoring (in handle restore) -> \(transaction.payment.productIdentifier)")
        
        let singleRestore = transaction.payment
        AdManager.sharedInstance.handleUserRestorePurchase(restoreType: singleRestore.productIdentifier) { isRestoreSuccesful in
            
            if isRestoreSuccesful == true {
                print("Ad should be removed since product is restored -> \(singleRestore.productIdentifier)")
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Restore transaction closed")
                return
                
            }
            else {
                print("something went wrong while trying to restore user non-consumable product i.e. ad ")
                return
            }
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            
            print("\n LOOK FOR RESTORE")
            
            print("in updatedTransactions: \(transaction.payment.productIdentifier)")
            
            print("LOOK FOR RESTORE \n")
            
            switch transaction.transactionState {
                
    //          App Store is notifying the app that purchase is taking place https://stackoverflow.com/a/33234069/14918173
                case .purchasing:
                    print("In purchasing")
                    break
                
                case .purchased:
                    print("In purchased")
                    handlePurchase(transaction)
                    break

                case .failed:
                    print("In failed")
                    handleFailedTransaction(transaction)

//              Don't need to restore consumables -> https://stackoverflow.com/a/14173940/14918173
//              About restore -> https://stackoverflow.com/a/35994375/14918173
                case .restored:
                    print("IN restored")
                    handleRestore(transaction)

    //          Unsure about what to do with deffered transaction -> https://stackoverflow.com/a/26371545/14918173
    //          Don't called finish transaction for defered
                case .deferred:
                    print("IN defered")
                    break

                @unknown default:
                    break
            }
        }
    }
    
    
    
    
    
}
