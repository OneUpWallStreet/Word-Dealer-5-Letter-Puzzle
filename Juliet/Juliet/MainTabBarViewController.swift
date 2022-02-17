//
//  MainTabBarViewController.swift
//  Juliet
//
//  Created by Arteezy on 2/1/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let WordleVC: UINavigationController = UINavigationController(rootViewController: WordleViewController())
    let ShopVC: UINavigationController = UINavigationController(rootViewController: ShopViewController())
    

    override func viewDidLoad() {
        
        WordleVC.title = "Home"
        ShopVC.title = "Shop"
        
        super.viewDidLoad()
        
        self.setViewControllers([WordleVC,ShopVC], animated: false)
        
        //iOS 15 tab bar is bugged, the background color is missing, this is a fix  found at "https://stackoverflow.com/questions/68688270/ios-15-uitabbarcontrollers-tabbar-background-color-turns-black"
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        guard let items = self.tabBar.items else {return}
        let imageName: Array<String> = ["house","cart"]
        
        for (index,item) in items.enumerated() {
            item.image = UIImage(systemName: imageName[index])
        }
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


