//
//  UITabbarController + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

extension UITabBarController {
    
    func createNav(with title: String, image: UIImage?, selectedImge: UIImage?, vc: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: vc)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.selectedImage = selectedImge
        navVC.tabBarItem.image = image
        return navVC
    }
    
}

