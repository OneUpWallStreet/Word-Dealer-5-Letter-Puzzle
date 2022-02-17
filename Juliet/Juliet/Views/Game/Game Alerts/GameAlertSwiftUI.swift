//
//  GameAlertSwiftUI.swift
//  Juliet
//
//  Created by Arteezy on 2/5/22.
//

import SwiftUI

struct GameAlertSwiftUI: View {
    
    @State var alertText: String 
    
    var body: some View {
        VStack{
            Text(alertText)
                .padding()
                .background(Color .black)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
    }
}

