//
//  UITabbarController + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import UIKit

extension UITabBarController {
    
    func createNav(with title: String, image: UIImage?, selectedImge: UIImage?, vc: UIViewController) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Gray._300], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appPrimaryColor], for: .selected)
        vc.tabBarItem.selectedImage = selectedImge
        vc.tabBarItem.image = image
        return vc
    }
    
}

