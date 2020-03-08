//
//  Extensions.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

// MARK: - UITableViewCell
extension UITableViewCell {
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
