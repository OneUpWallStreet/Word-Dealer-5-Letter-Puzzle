//
//  GameOverViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/6/22.
//

import UIKit
import SwiftUI

//protocol GamePauseSwiftUIDelegate {
//    func homeButtonPressedInSwiftUI()
//    func resumeButtonPressedInSwiftUI()
//    func restartButtonPressedInSwiftUI()
//}


protocol GameOverSwiftUIDelegate {
    func homeButtonPressedInSwiftUIGameOver()
    func restartButtonPressedInSwiftUIGameOver()
}

protocol GameOverViewControllerDelegate {
    func homeButtonPressedInGameOver()
    func restartButtonPressedInGameOver()
    func dismissGameOverMenu()
}

class GameOverViewController: UIViewController {
    
    var didWin: Bool = true
    var secretWord: String = ""
    
    var delegate: GameOverViewControllerDelegate?

    private func configureGameOverSwiftUIView() {
        
        print("DidWin in GameOVerViewCOntroller=: \(didWin)")

        let gameOverSwiftUIView = UIHostingController(rootView: GameOverSwiftUIView(secretWord: secretWord, didWin: didWin))

        gameOverSwiftUIView.rootView.delegate = self
        
        addChild(gameOverSwiftUIView)
        gameOverSwiftUIView.view.frame = view.frame
        gameOverSwiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        gameOverSwiftUIView.view.layer.cornerRadius = 10
        
        view.addSubview(gameOverSwiftUIView.view)
        
        NSLayoutConstraint.activate([
            gameOverSwiftUIView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameOverSwiftUIView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameOverSwiftUIView.view.topAnchor.constraint(equalTo: view.topAnchor),
            gameOverSwiftUIView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGameOverSwiftUIView()
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
