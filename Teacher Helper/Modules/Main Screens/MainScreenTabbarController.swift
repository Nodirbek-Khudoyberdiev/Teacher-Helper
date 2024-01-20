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
        setTitleColor()
    }
    
    private func setTitleColor(){
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Gray._300], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appPrimaryColor], for: .selected)
    }
    
    private func setTabs(){
        let resourceSelectedImage = UIImage(named: "book-open-selected")
        let resourceImage = UIImage(named: "book-open")
        let resourceVC = ResourcesScreenVC()
        let resourceNavVC = createNav(with: "Ресурсы", image: resourceImage, selectedImge: resourceSelectedImage, vc: resourceVC)
        
        let homeSelectedImage = UIImage(named: "home-selected")
        let homeImage = UIImage(named: "home")
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .white
        let homeNavVC = createNav(with: "Главная", image: homeImage, selectedImge: homeSelectedImage, vc: homeVC)
        
        let calendarSelectedImage = UIImage(named: "calendar-date-selected")
        let calendarImage = UIImage(named: "calendar-date")
        let calendarVC = UIViewController()
        calendarVC.view.backgroundColor = .white
        let calendarNavVC = createNav(with: "Главная", image: calendarImage, selectedImge: calendarSelectedImage, vc: calendarVC)
        
        setViewControllers([homeNavVC, resourceNavVC, calendarNavVC], animated: true)
    }

    private func createNav(with title: String, image: UIImage?, selectedImge: UIImage?, vc: UIViewController) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.selectedImage = selectedImge
        vc.tabBarItem.image = image
        return vc
    }
    
}
