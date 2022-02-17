//
//  ShopSwiftUIView.swift
//  Juliet
//
//  Created by Arteezy on 2/10/22.
//

import SwiftUI
import StoreKit
import Lottie

struct ShopSwiftUIView: View {
    
    @ObservedObject var shopVM: ShopSwiftUIViewModel = ShopSwiftUIViewModel()
    var lightning = LottieView(name: "lightning")
    var young = LottieView(name: "young")
    
    
    struct SizeConstants {
        static let boxWidth: CGFloat = UIScreen.main.bounds.width-30
        static let boxHeight: CGFloat = 225
    }
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                gameplayProducts
                adProducts
                Spacer()
            }
        }
        .padding()

    }
    
    var adProducts: some View {
        VStack{
            adHeader
            ForEach(shopVM.availableAdProducts) { adProduct in
                singleAdElement(adProduct)
            }
        }
    }
    
    var gameplayProducts: some View {
        VStack{
            gameplayHeader
            ForEach(shopVM.availableGameplayProducts) { gameplayProduct in
                singleGameplayElement(gameplayProduct)

            }
        }
    }
    
    
    var adHeader: some View {
        HStack{
            VStack(alignment: .leading){
               Text("Ads")
                    .font(.largeTitle)
                    .bold()
                Text("Create Immersion")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            young
                .frame(width: 60, height: 60, alignment: .center)
                .onAppear {
                    young.animationView.play()
                }

        }
    }
    var gameplayHeader: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Gameplay")
                    .font(.largeTitle)
                    .bold()
                Text("Be prepared")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            lightning
                .frame(width: 60, height: 60, alignment: .center)
                .onAppear {
                    lightning.animationView.play()
                }
            
        }
    }
    
    @ViewBuilder
    private func singleAdElement(_ productDetail: ProductDetailInfo) -> some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
                .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.wordleBorderGray, lineWidth: 2)
                )
            VStack(alignment: .leading){
                
                HStack{
                    Text("\(productDetail.product.localizedTitle)")
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color .white)
                        .padding()
                    
                    Spacer()
                    
                    if productDetail.isBestSeller {
                        Image("trophy")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.trailing)
                    }
                    
                    if productDetail.product.productIdentifier == "Juliet.UIKit.Feb.One.2022.Juliet.removeBannerAds" {
                        Image("star")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.trailing)
                    }

                }
                .background(Color . green)
                

                
                HStack{
                    Text("\(productDetail.product.localizedDescription)")
                        .frame(width: 170, height: 70, alignment: .center)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(productDetail.product.regularPrice ?? productDetail.product.price.stringValue)")
                        .bold()
                        .font(.title)
                }
                .padding([.leading,.trailing,.bottom])
                
                
                HStack{
                    Spacer()
                    
                    Button {
                        IAPManager.sharedInstance.buySelectedProduct(productDetail.product)
                    } label: {
                        ZStack{
                            Capsule(style: .continuous)
                                .fill(Color .green)
                                .frame(width: 150, height: 50, alignment: .center)
                            
                            HStack(alignment: .center){
                                
                                Image("check")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                
                                Text("Enable")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                    }

                    Spacer()
                }

                
                
                Spacer()
            }
            .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
        }
        .padding(.vertical)
        
        
    }
    
    @ViewBuilder
    private func singleGameplayElement(_ productDetail: ProductDetailInfo) -> some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
                .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.wordleBorderGray, lineWidth: 2)
                )
            VStack(alignment: .leading){
                
                HStack{
                    Text("\(productDetail.product.localizedTitle)")
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color .yellow)
                        .padding()
                    
                    Spacer()
                    
                    if productDetail.isBestSeller {
                        Image("trophy")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.trailing)
                    }

                }
                .background(Color . red)
                

                
                HStack{
                    Text("\(productDetail.product.localizedDescription)")
                        .frame(width: 170, height: 70, alignment: .center)
//                        .background(Color .pink)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(productDetail.product.regularPrice ?? productDetail.product.price.stringValue)")
                        .bold()
                        .font(.title)
                }
                .padding([.leading,.trailing,.bottom])
                
                
                HStack{
                    Spacer()
                    
                    Button {
                        IAPManager.sharedInstance.buySelectedProduct(productDetail.product)
                    } label: {
                        ZStack{
                            Capsule(style: .continuous)
                                .fill(Color .red)
                                .frame(width: 150, height: 50, alignment: .center)
                            
                            HStack(alignment: .center){
    //                          This is kind of odd but the bestseller is the 30 bundle
                                if productDetail.isBestSeller {
                                    Image("bolt")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                    Text(" x30")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                                else {
                                    Image("bolt")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                    Text(" x5")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                            }
                        }
                    }

                    

                    Spacer()
                }

                
                
                Spacer()
            }
            .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
        }
        .padding(.vertical)
        
        
    }
    
    
//    var gameplay: some View {
//
//            ZStack{
//                let product = shopVM.availableProducts.first!
//
//                RoundedRectangle(cornerRadius: 10, style: .continuous)
//                    .fill(.white)
//                    .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color.wordleBorderGray, lineWidth: 2)
//                    )
//                VStack(alignment: .leading){
//
//                    HStack{
//                        Text("\(product.localizedTitle)")
//                            .bold()
//                            .font(.title3)
//                            .foregroundColor(Color .yellow)
//                            .padding()
//
//                        Spacer()
//
//                        Image("trophy")
//                            .resizable()
//                            .frame(width: 40, height: 40, alignment: .center)
//
//                        Spacer()
//
//                    }
//                    .background(Color . red)
//
//
//
//                    HStack{
//                        Text("\(product.localizedDescription)")
//                            .foregroundColor(.gray)
//                        Spacer()
//                        Text("\(product.regularPrice!)")
//                            .font(.title)
//                    }
//                    .padding([.leading,.trailing,.bottom])
//
//
//                    HStack{
//                        Spacer()
//                        ZStack{
//                            Capsule(style: .continuous)
//                                .fill(Color .red)
//                                .frame(width: 150, height: 50, alignment: .center)
//
//                            HStack(alignment: .center){
//
//                                Image("bolt")
//                                    .resizable()
//                                    .frame(width: 30, height: 30, alignment: .center)
//                                Text(" x30")
//                                    .foregroundColor(.yellow)
//                                    .bold()
//                            }
//                        }
//                        Spacer()
//                    }
//
//
//
//                    Spacer()
//                }
//                .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
//
//            }
//    }

    
}
