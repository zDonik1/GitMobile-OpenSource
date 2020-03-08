//
//  AppNavigationController.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.barStyle = .blackOpaque
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = Colors.githubDarkGray
    }
    
}
