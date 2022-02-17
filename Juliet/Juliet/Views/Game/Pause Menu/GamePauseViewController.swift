//
//  GamePauseViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/3/22.
//


import UIKit
import SwiftUI

protocol GamePauseSwiftUIDelegate {
    func homeButtonPressedInSwiftUI()
    func resumeButtonPressedInSwiftUI()
    func restartWithEnergyButtonPressedInSwiftUI()
    func restartWithAdButtonPressedInSwiftUI()
}

protocol GamePauseViewControllerDelegate {
    func resumeButtonPressed()
    func homeButtonPressed()
    func restartWithEnergyButtonPressed()
    func restartWithAdButtonPressed()
    
}

class GamePauseViewController: UIViewController {
    
    var delegate: GamePauseViewControllerDelegate?
    let gamePauseSwiftUIView = UIHostingController(rootView: GamePauseSwiftUI())
    
    private func configurePauseSwiftUIView() {
        
        gamePauseSwiftUIView.rootView.delegate = self
        addChild(gamePauseSwiftUIView)
        gamePauseSwiftUIView.view.frame = view.frame
        
        gamePauseSwiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        
        gamePauseSwiftUIView.view.layer.cornerRadius = 10
        
        view.addSubview(gamePauseSwiftUIView.view)
        
        NSLayoutConstraint.activate([
            gamePauseSwiftUIView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gamePauseSwiftUIView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gamePauseSwiftUIView.view.topAnchor.constraint(equalTo: view.topAnchor),
            gamePauseSwiftUIView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePauseSwiftUIView()
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
