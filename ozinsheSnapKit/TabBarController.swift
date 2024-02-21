//
//  TabBarController.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 05.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    func setupTabs(){
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favouritesVC = FavouritesViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "HomeActive" ))
        
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SearchActive" ))
        
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "ProfileActive" ))
        
        favouritesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favourite"), selectedImage: UIImage(named: "FavouriteActive" ))
        
        
        setViewControllers([homeVC, searchVC, favouritesVC, profileVC], animated: false)
    }
}
