//
//  UIViewController+Theme.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

extension UINavigationController {

    func applytheme() {

        navigationBar.barTintColor = .todoBlue
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.shadowImage = UIImage()

        hidesBarsOnSwipe = true
    }
}
