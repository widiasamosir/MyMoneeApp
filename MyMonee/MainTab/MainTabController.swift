//
//  MainTabController.swift
//  SampleApp
//
//  Created by Macbook on 11/05/21.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        let home = MainViewController(nibName: String(describing: MainViewController.self), bundle: nil)
        let homeTab = UINavigationController(rootViewController: home)
        let homeImage = UIImage(named: "homeImage")?.withRenderingMode(.alwaysOriginal)
        let homeImageSelected = UIImage(named: "homeImageSelected")?.withRenderingMode(.alwaysOriginal)
        
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImageSelected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)], for: .selected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        homeTab.tabBarItem.tag = 0
        
        let impian = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        let impianTab = UINavigationController(rootViewController: impian)
        let impianImage = UIImage(named: "impianImage")?.withRenderingMode(.alwaysOriginal)
        let impianImageSelected = UIImage(named: "impianImageSelected")?.withRenderingMode(.alwaysOriginal)
        impianTab.tabBarItem = UITabBarItem(title: "Impian", image: impianImage, selectedImage: impianImageSelected)
        impianTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)], for: .selected)
        impianTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        impianTab.tabBarItem.tag = 1
        
        let profile = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileTab = UINavigationController(rootViewController: profile)
        let profileImage = UIImage(named: "profileImage")?.withRenderingMode(.alwaysOriginal)
        let profileImageSelected = UIImage(named: "profileImageSelected")?.withRenderingMode(.alwaysOriginal)
        profileTab.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileImageSelected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)], for: .selected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        profileTab.tabBarItem.tag = 2
        
        self.viewControllers = [homeTab, impianTab, profileTab]
    }

    

}
