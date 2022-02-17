//
//  GameAlertViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/5/22.
//

import UIKit
import SwiftUI

class GameAlertViewController: UIViewController {
    
//    let gameAlertSwiftUIView = UIHostingController(rootView: GameAlertSwiftUI(alertText: ""))
    
    var alertText: String  = ""

    private func configureAlertSwiftUIView() {
        
        let gameAlertSwiftUIView = UIHostingController(rootView: GameAlertSwiftUI(alertText: self.alertText))

        
        addChild(gameAlertSwiftUIView)
        gameAlertSwiftUIView.view.frame = view.frame
        gameAlertSwiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        
//        gameAlertSwiftUIView.view.layer.cornerRadius = 10
        
        view.addSubview(gameAlertSwiftUIView.view)
        
        NSLayoutConstraint.activate([
            gameAlertSwiftUIView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameAlertSwiftUIView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameAlertSwiftUIView.view.topAnchor.constraint(equalTo: view.topAnchor),
            gameAlertSwiftUIView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAlertSwiftUIView()
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
