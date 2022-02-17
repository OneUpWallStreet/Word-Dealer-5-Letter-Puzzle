//
//  GamePauseSwiftUI.swift
//  Juliet
//
//  Created by Arteezy on 2/3/22.
//

import SwiftUI

struct GamePauseSwiftUI: View {
    
    var delegate: GamePauseSwiftUIDelegate?
    @ObservedObject var gamePauseVM: GamePauseAndGameOverViewModel = GamePauseAndGameOverViewModel()
    
    var body: some View {
         pauseMenu
     }
    
    var header: some View {
        HStack{
            Text("Pause")
                .bold()
                .font(.largeTitle)
                .padding()
                .foregroundColor(.blue)
            
            Spacer()
            userEnergy
        }
    }
    
    var resumeButton: some View {
        VStack{
            Image("play_image")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
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
            
        }
        .padding()
        .background(Color .sharkBlue)
        .cornerRadius(10)
    }
    
    var firstRow: some View {
        HStack{
            Spacer()
            Button {
                delegate?.resumeButtonPressedInSwiftUI()
            } label: {
                resumeButton
            }
            Spacer()
            Button {
                delegate?.homeButtonPressedInSwiftUI()
            } label: {
                homeButton
            }
            Spacer()
        }
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
    
    
    var secondRow: some View {
        HStack{
            Spacer()
            Button {
//              Only Restart if uesr has energy, otherwise ask him to make a purchase
                if gamePauseVM.doesUserHaveEnergyToRestart() {
                    delegate?.restartWithEnergyButtonPressedInSwiftUI()
                }
                else {
                    gamePauseVM.promptUserToPurchaseEnergy()
                }
            } label: {
                restartEnergyButton
            }
            Spacer()
            Button {
                delegate?.restartWithAdButtonPressedInSwiftUI()
            } label: {
                restartAdButton
            }

            Spacer()
        }
    }
     
     var pauseMenu: some View {
         VStack{
             header
             firstRow
             Spacer()
             secondRow
             Spacer()
         }
         .frame(width: UIScreen.main.bounds.width-30, height: 350, alignment: .center)


     }
     
     var userEnergy: some View {
         HStack{
             Image("bolt")
                 .resizable()
                 .frame(width: 27.5, height: 27.5, alignment: .center)
                 .clipShape(Circle())
             Text(String(gamePauseVM.userEnergy))
                 .foregroundColor(.white)
                 .bold()
                 .padding([.horizontal],20)
                 .padding([.vertical],5)
                 .background(Color .customGreen)
                 .cornerRadius(5)
         }
         .padding()
     }
}

