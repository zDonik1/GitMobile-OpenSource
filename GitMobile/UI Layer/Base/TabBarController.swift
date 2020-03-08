//
//  TabBarController.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = Colors.githubOrange
        
        let searchRepositoriesViewController = SearchRepositoriesViewController(viewModelFactory: self)
        searchRepositoriesViewController.tabBarItem = UITabBarItem(
            title: "Repositories",
            image: UIImage(named: "search"),
            selectedImage: UIImage(named: "search")
        )
        
        let myRepositoriesViewController = MyRepositoriesViewController()
        myRepositoriesViewController.tabBarItem = UITabBarItem(
            title: "My Repositories",
            image: UIImage(named: "list"),
            selectedImage: UIImage(named: "list")
        )
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "user_male"),
            selectedImage: UIImage(named: "user_male")
        )
        
        self.viewControllers = [
            AppNavigationController(rootViewController: searchRepositoriesViewController),
            AppNavigationController(rootViewController: myRepositoriesViewController),
            AppNavigationController(rootViewController: profileViewController)
        ]
    }
}

// MARK: - Factory Implementations
extension TabBarController: SearchRepositoriesViewModelFactory {
    func makeViewModel() -> SearchRepositoriesViewModel {
        return SearchRepositoriesViewModel()
    }
}

extension TabBarController: MyRepositoriesViewModelFactory {
    func makeViewModel() -> MyRepositoriesViewModel {
        return MyRepositoriesViewModel()
    }
}

extension TabBarController: ProfileViewModelFactory {
    func makeViewModel() -> ProfileViewModel {
        return ProfileViewModel()
    }
}
