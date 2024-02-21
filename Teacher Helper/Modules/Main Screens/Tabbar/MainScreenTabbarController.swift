//
//  MainScreenTabbarController.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import UIKit
import RxCocoa
import RxSwift

class MainScreenTabbarController: UITabBarController {
    
    private let bag = DisposeBag()
    private var coodinators: [ReactiveCoordinator<Void>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabs()
        configureSelection()
        setup()
    }
    
}

private extension MainScreenTabbarController {
    func setup(){
        // bug was in ipad, so that is why this was added
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let items = tabBar.items {
                // Setting the title text color of all tab bar items:
                for item in items {
                    item.setTitleTextAttributes([.foregroundColor: UIColor.appPrimaryColor], for: .selected)
                    item.setTitleTextAttributes([.foregroundColor: UIColor.Gray._300], for: .normal)
                }
            }
        } else {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .white
            
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appPrimaryColor]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Gray._300]
            tabBar.standardAppearance = tabBarAppearance
        }
    }
    
    func setTabs(){
        let resourceCoordinator = ResourcesScreenCoordinator()
        let resourceNavVC = createNav(with: "Ресурсы", image: .resourcesBookOpen, selectedImge: .resourcesBookOpenSelected, vc: resourceCoordinator.vc)
        self.coodinators.append(resourceCoordinator)
        
        let homeVC = MainViewController()
        let homeNavVC = createNav(with: "Главная", image: .homeImage, selectedImge: .homeSelectedImage, vc: homeVC)
        
        let calendarVC = UIViewController()
        calendarVC.view.backgroundColor = .white
        let calendarNavVC = createNav(with: "Главная", image: .calendarImage, selectedImge: .calendarSelectedImage, vc: calendarVC)
        
        setViewControllers([homeNavVC, resourceNavVC, calendarNavVC], animated: true)
    }
    
    func configureSelection(){
        self.coodinators.forEach({
            $0.start()
                .subscribe()
                .disposed(by: bag)
        })
    }
}
