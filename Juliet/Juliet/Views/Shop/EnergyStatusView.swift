//
//  EnergyStatusView.swift
//  Juliet
//
//  Created by Arteezy on 2/11/22.
//

import UIKit

class EnergyStatusView: UIView {

    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = 0.convertToString(UserSessionManager.sharedInstance.userEnergy)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .gray
        return label
    }()
    
    private func updateUserEnergyInNavigationBar() {
        DispatchQueue.main.async {
            self.label.text = 0.convertToString(UserSessionManager.sharedInstance.userEnergy)
        }
    }
    
    let boltImage: UIImageView = {
        let boltImage = UIImageView()
        boltImage.image = UIImage(named: "bolt")
        boltImage.translatesAutoresizingMaskIntoConstraints = false
        return boltImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UserSessionManager.sharedInstance.updateShopEnergyInNavigationBar = updateUserEnergyInNavigationBar
    
        addSubview(label)
        addSubview(boltImage)
        
        NSLayoutConstraint.activate([
            boltImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            boltImage.widthAnchor.constraint(equalToConstant: 20),
            boltImage.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: boltImage.trailingAnchor,constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
