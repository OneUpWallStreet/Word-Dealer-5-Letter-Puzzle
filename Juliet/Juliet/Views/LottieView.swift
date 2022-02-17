//
//  LottieView.swift
//  Juliet
//
//  Created by Arteezy on 2/2/22.
//

import SwiftUI
import Lottie


/// Simple View from showing lottie Views, from -> https://designcode.io/swiftui-handbook-lottie-animation
struct LottieView: UIViewRepresentable {
    
    /// Name of Lottie JSON
    var name: String
    
    /// Mainly for switching between, play once or loop forever
    var loopMode: LottieLoopMode = .loop
    let animationView = AnimationView()
    
    /// For Aspect Ratio of animation
    var contentMode: UIView.ContentMode = .scaleAspectFit

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

//        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }
        

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


