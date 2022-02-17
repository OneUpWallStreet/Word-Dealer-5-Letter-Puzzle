//
//  WordleMainMenu.swift
//  Juliet
//
//  Created by Arteezy on 2/2/22.
//

import SwiftUI
import Lottie


struct WordleMainMenu: View {

    var delegate: WordleViewControllerDelegate?
    @ObservedObject var wordleMainMenuVM: WordleMainMenuViewModel = WordleMainMenuViewModel()
    var boyStudy = LottieView(name: "boyStudy")
    var gift = LottieView(name: "gift")

    var body: some View {
        VStack {
            headerView
            Spacer()
            middleView
            Spacer()
            playButtons
            Spacer()
        }
        .onAppear {
            boyStudy.animationView.play()
            gift.animationView.play()
//          Reset disabled buttons
        }
    }
    
    var userLevel: some View {
        Text(String(wordleMainMenuVM.userWins))
                .bold()
                .foregroundColor(.white)
                .frame(width: 35, height: 35, alignment: .center)
                .background(Color .customBlue)
                .clipShape(Circle())
    }
    var userEnergy: some View {
        HStack{
            Image("bolt")
                .resizable()
                .frame(width: 27.5, height: 27.5, alignment: .center)
                .clipShape(Circle())
            Text("\(wordleMainMenuVM.userEnergy)")
                .foregroundColor(.white)
                .bold()
                .padding([.horizontal],20)
                .padding([.vertical],5)
                .background(Color .customGreen)
                .cornerRadius(5)
        }
    }
    var headerView: some View {
        
        VStack{
            HStack{
                userLevel
                Spacer()
                userEnergy
            }
        }
        .padding([.top,.leading,.trailing])

    }
    
    var playButtons: some View {
        HStack{
                Button {
                    delegate?.playEnergyButtonPressed()
                } label: {
                    energyPlayButton
                }
            Spacer()
                Button {
                    delegate?.playAdButtonPressed()
                } label: {
                    adPlayButton
                }
        }
        .padding()
    }
    
    var adPlayButton: some View {
        VStack(spacing: 1){
            Text("Play")
                .bold()
                .foregroundColor(.white)
                .font(.title)

            HStack(spacing: 0){
                Image("playVideo")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                Text("Ad")
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading,10)
            }

        }
        .padding([.leading,.trailing],40)
        .padding([.top,.bottom],5)
        .background(Color .yellow)
        .cornerRadius(5)
    }
    var energyPlayButton: some View {
        VStack(spacing: 1){
            Text("Play")
                .bold()
                .foregroundColor(.white)
                .font(.title)

            HStack(spacing: 0){
                Image("bolt")
                    .resizable()
                    .frame(width: 27.5, height: 27.5, alignment: .center)
                Text("x5")
                    .foregroundColor(.white)
                    .bold()
            }

        }
        .padding([.leading,.trailing],40)
        .padding([.top,.bottom],5)
        .background(Color .playBlue)
        .cornerRadius(5)
    }
    var middleView: some View {
        boyStudy
            .frame(width: 275, height: 275, alignment: .center)
    }
    



}

