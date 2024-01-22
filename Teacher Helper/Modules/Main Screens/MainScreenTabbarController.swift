//
//  MainScreenTabbarController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit

class MainScreenTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabs()
    }
    
    private func setTabs(){
        let resourceVC = ResourcesScreenVC()
        let resourceNavVC = createNav(with: "Ресурсы", image: .resourcesBookOpen, selectedImge: .resourcesBookOpenSelected, vc: resourceVC)
        
        
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .white
        let homeNavVC = createNav(with: "Главная", image: .homeImage, selectedImge: .homeSelectedImage, vc: homeVC)
        
        
        let calendarVC = UIViewController()
        calendarVC.view.backgroundColor = .white
        let calendarNavVC = createNav(with: "Главная", image: .calendarImage, selectedImge: .calendarSelectedImage, vc: calendarVC)
        
        setViewControllers([homeNavVC, resourceNavVC, calendarNavVC], animated: true)
    }

    private func createNav(with title: String, image: UIImage?, selectedImge: UIImage?, vc: UIViewController) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Gray._300], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appPrimaryColor], for: .selected)
        vc.tabBarItem.selectedImage = selectedImge
        vc.tabBarItem.image = image
        return vc
    }
    
}
