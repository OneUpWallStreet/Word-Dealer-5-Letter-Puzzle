//
//  GameOverSwiftUI.swift
//  Juliet
//
//  Created by Arteezy on 2/6/22.
//

import SwiftUI

struct GameOverSwiftUIView: View {
    
    
    var secretWord: String
    var didWin: Bool
    
    
    var delegate: GameOverSwiftUIDelegate?
    
    var body: some View {
        VStack(spacing: 0){
            headerView
            Spacer()
            buttons
            Spacer()
                
        }
        .padding()
    }
    
    var userEnergy: some View {
        HStack{
            Image("bolt")
                .resizable()
                .frame(width: 27.5, height: 27.5, alignment: .center)
                .clipShape(Circle())
            Text(String(UserSessionManager.sharedInstance.userEnergy))
                .foregroundColor(.white)
                .bold()
                .padding([.horizontal],10)
                .padding([.vertical],5)
                .background(Color .customGreen)
                .cornerRadius(5)
        }
        .padding()
    }
    
    
    var headerView: some View {
        HStack{
            if didWin {
                LottieView(name: "correct", loopMode: .playOnce)
                    .frame(width: 70, height: 70, alignment: .center)
                
                Spacer()
                
                Text(secretWord)
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.green)
                Spacer()
                userEnergy

            }
            else {
                LottieView(name: "wrong", loopMode: .playOnce)
                    .frame(width: 70, height: 70, alignment: .center)
                
                Spacer()
                
                Text(secretWord)
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.red)
                Spacer()
                userEnergy

            }
            
        }
        .onAppear {
            print("didWin: \(didWin)")
        }
    }
    
    


    
    
    var buttons: some View {
        
        HStack{

            Spacer()
            Button {
                delegate?.restartButtonPressedInSwiftUIGameOver()
            } label: {
                restartAdButton
            }
            Spacer()
            
            Button {
                delegate?.homeButtonPressedInSwiftUIGameOver()
            } label: {
                homeButton
            }
            
            Spacer()

        }
        
    }
    
    
    
//    New stuff
    
    var restartAdButton: some View {
        VStack{
            Image("restart")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            
            HStack(spacing: 5){
                Image("playVideo")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text("Ad")
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color .sharkBlue)
        .cornerRadius(10)
    }
    
    var homeButton: some View {
        VStack{
            Image("home")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            
            HStack(spacing: 0){
//                Spacer()
                Text("Home")
                    .bold()
                    .foregroundColor(.white)
//                Spacer()
            }
            
        }
        .padding()
        .background(Color .sharkBlue)
        .cornerRadius(10)
    }
    
    
    var restartEnergyButton: some View {
        VStack{
            Image("restart")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            
            HStack(spacing: 0){
                Image("bolt")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text("x5")
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color .sharkBlue)
        .cornerRadius(10)
    }
    
}

