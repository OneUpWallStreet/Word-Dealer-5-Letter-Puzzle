//
//  ViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/1/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        animationView.animation = Animation.named("gift")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        

        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        animationView.play()

        // Do any additional setup after loading the view.
    }


}

