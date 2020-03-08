//
//  Colors.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

struct Colors {
    
    private static func rgb(_ red: CGFloat,
                            _ green: CGFloat,
                            _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0,
                       green: green / 255,
                       blue: blue / 255,
                       alpha: 1.0)
    }
    
    static let githubDarkGray = Colors.rgb(37, 40, 45)
    static let githubOrange   = Colors.rgb(216, 124, 71)
}
